KptIt.controllers :posts do

  get :index do
    @post = Post.new
    @type = params[:type] || 'keep'
    render 'posts/index'
  end

  post :index, :with => :type do
    post = Post.new(params[:post])
    post.type = params[:type]
    flash[:error] = "creating post faled.." unless post.save

    Pusher["post-channel"].trigger(
      "post-created-event",
      post
    )

    redirect "#{url(:posts, :index)}?type=#{params[:type]}"
  end

  delete :destroy do
    Post.all.map(&:destroy)
    redirect url(:posts, :index)
  end

end
