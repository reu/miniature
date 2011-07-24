require File.join(File.dirname(__FILE__), "post")

class Miniature < Sinatra::Base
  get "/" do
    erb :index, :locals => { :posts => Post.all }
  end

  get "/:slug" do
    post = Post.find_by_slug(params[:slug])

    raise Sinatra::NotFound unless post

    erb :post, :locals => { :post => post }
  end

  not_found do
    "Post not found"
  end

  helpers do
    def markdown(content)
      Redcarpet.new(content, :smart, :gh_blockcode).to_html
    end
  end
end
