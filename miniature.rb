class Miniature < Sinatra::Base
  get "/" do
    erb :index, :locals => { :posts => Post.find_all }
  end

  get "/:slug" do
    post = Post.find_by_slug(params[:slug])

    erb :post, :locals => { :post => post }
  end
end
