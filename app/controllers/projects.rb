KptIt::App.controllers :projects do

  get :new, map: '/new' do
    @project = Project.new
    render '/projects/new'
  end

  post :new, map: '/new' do
    @project = Project.new(params[:project])
    if @project.save
      session[:admin] = true
      redirect "/#{@project.token}"
    else
      render '/projects/new'
    end
  end


  get :index, map: "/:project_token", :provides => [:html, :md] do
    @project = Project.where(token: params[:project_token]).first
    return 404 unless @project
    @post = Post.new
    @kind = params[:kind] || 'keep'

    render '/projects/show'
  end

  delete :index, map: "/:project_token" do
    project = Project.where(token: params[:project_token]).first
    return 404 unless project
    project.destroy
    redirect '/'
  end

  post :index, map: "/:project_token" do
    project = Project.where(token: params[:project_token]).first
    return 404 unless project
    session[:admin] = project.has_password?(params[:password])
    redirect "/#{project.token}"
  end

  put :index, map: "/:project_token" do
    project = Project.where(token: params[:project_token]).first
    return 404 unless project
    if session[:admin]
      project.accept = !project.accept
      project.save!
      redirect "/#{project.token}"
    else
      return 422
    end

  end


  post :index, map: "/:project_token/:kind", provides: :js do
    @project = Project.where(token: params[:project_token]).first
    return 404 unless @project

    @post = @project.posts.new(params[:post])
    @post.kind = params[:kind]
    if @project.accept && @post.save
      session[:posts] ||= []
      session[:posts] << @post.token
      Pusher[@project.token].trigger(
        "post-event",
        render('/projects/post_result'),
        params[:socket_id]
      )
    else
      return 422
    end
  end


  delete :post, map: "/:project_token/:post_token", provides: :js do
    @project = Project.where(token: params[:project_token]).first
    return 404 unless @project
    post = @project.posts.where(token: params[:post_token]).first
    @kind = post.kind
    if session[:admin] || (session[:posts] && session[:posts].include?(post.token))
      post.destroy
      Pusher[@project.token].trigger(
        "post-event",
        render('/projects/delete_result')
      )
    else
      return 403
    end
  end

end
