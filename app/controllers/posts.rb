KptIt.controllers :posts do

  get :index do
    @post = Post.new
    render 'posts/index'
  end

  post :index, :with => :type do
    post = Post.new(params[:post])
    post.type = params[:type]
    flash[:error] = "creating post faled.." unless post.save

    redirect url(:posts, :index)
  end

  delete :destroy do
    redirect url(:posts, :index)
  end

end
