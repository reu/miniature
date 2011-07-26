require File.join(File.dirname(__FILE__), "post")

class Miniature < Sinatra::Base
  BLOG_TITLE    = "Miniature"
  DISQUS_CONFIG = { :shortname => 'your.disqus.shortname' }.freeze

  set :public, File.join(File.dirname(__FILE__), "..", "public")

  get "/" do
    erb :index, :locals => { :posts => Post.all }
  end

  get "/:year/:month/:day/:slug" do
    post = Post.find_by_slug(params[:slug])

    raise Sinatra::NotFound unless post

    erb :post, :locals => { :post => post, :show_comments => true }
  end

  not_found do
    "Post not found"
  end

  helpers do
    def markdown(content)
      Redcarpet.new(content, :hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode).to_html
    end
  end
end
