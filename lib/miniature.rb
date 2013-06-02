require_relative "markdown_renderer"
require_relative "post"

class MiniatureConfig < Sinatra::Base
  configure do
    set :app_file, File.expand_path(File.dirname(__FILE__), "..")

    set :blog_title, "Miniature"
  end
end

class CoffeeHandler < MiniatureConfig
  configure do
    set :views, "assets/coffee"
  end

  get "/coffee/:filename.js" do
    coffee params[:filename].to_sym
  end
end

class SassHandler < MiniatureConfig
  configure do
    set :views, "assets/sass"

    Compass.configuration do |config|
      config.project_path = root
      config.sass_dir = "assets/sass"
      config.css_dir = "public"
    end
  end

  get "/style.css" do
    headers 'Content-Type' => 'text/css; charset=utf-8'
    sass :style, Compass.sass_engine_options
  end
end

class Miniature < MiniatureConfig
  configure do
    enable :logging
  end

  use CoffeeHandler
  use SassHandler

  configure :production do
    memcache_client = Dalli::Client.new ENV["MEMCACHE_URL"],
                                        :username => ENV["MEMCACHE_USERNAME"],
                                        :password => ENV["MEMCACHE_PASSWORD"]

    use Rack::Cache, :entitystore => memcache_client,
                     :metastore   => memcache_client
  end

  get "/" do
    cache_control :public, :max_age => 60
    erb :index, :locals => { :posts => Post.all }
  end

  get "/rss" do
    cache_control :public, :max_age => 60
    builder :rss
  end

  get "/:year/:month/:day/:slug" do
    post = Post.find_by_slug(params[:slug]) or raise Sinatra::NotFound
    raise Sinatra::NotFound unless post.published?

    cache_control :public, :max_age => 60
    etag post.cache_key

    erb :post, :locals => { :post => post }
  end

  get "/draft/:slug" do
    post = Post.find_by_slug(params[:slug]) or raise Sinatra::NotFound
    erb :post, :locals =>  { :post => post }
  end

  helpers do
    def blog_title
      settings.blog_title
    end

    def format_date(date)
      date.strftime("%Y-%m-%d")
    end

    def markdown(text)
      options = {
        :fenced_code_blocks => true,
        :strikethrough => true,
        :autolink => true,
        :hard_wrap => true
      }

      Redcarpet::Markdown.new(MarkdownRenderer, options).render(text)
    end
  end
end
