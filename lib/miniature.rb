require File.join(File.dirname(__FILE__), "post")

class Miniature < Sinatra::Base
  get "/" do
    erb :index, :locals => { :posts => Post.all }
  end

  get "/:slug" do
    post = Post.find_by_slug(params[:slug])

    erb :post, :locals => { :post => post }
  end

  helpers do
    def markdown(content)
      Redcarpet.new(content, :smart, :gh_blockcode).to_html
    end
  end
end
