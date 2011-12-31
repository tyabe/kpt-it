KptIt.controllers :projects do

  get :index do
    @new_project = Project.new
    @manage_projects = current_account.projects.desc(:created_at)
    @join_projects = Post.where(author_id: current_account.id).desc(:created_at).map(&:project).uniq # TODO
    render '/projects/index'
  end

  post :index, provides: :js do
    project = current_account.projects.new(params[:project])
    if project.save
      %{location.href="/projects/#{project.token}/created"}
    else
      %{alert("#{project.errors.full_messages.join("\n")}");}
    end
  end

  get :created, map: "/projects/:token/created" do
    @project = Project.where(token: params[:token]).first
    return 404 unless @project
    @url = request.env["REQUEST_URI"].sub("/created",'')
    render 'projects/created'
  end

  get :index, with: :token do
    @project = Project.where(token: params[:token]).first
    return 404 unless @project
    @post = Post.new
    @type = params[:type] || 'keep'
    render '/projects/show'
  end

  delete :index, with: :token do
    project = Project.where(token: params[:token]).first
    return 404 unless project && project.author == current_account

    project.destroy
    redirect '/projects'
  end

  %w[keep problem try].each do |type|
    post type.to_sym, map: "/projects/:token/#{type}", provides: :js do
      project = Project.where(token: params[:token]).first
      return 404 unless project

      post = project.posts.new(params[:post])
      post.type = params[:type]
      post.author = current_account

      if post.save
        Pusher[project.token].trigger(
          "post-event",
          (project.posts.where(type: post.type).count - 1 <= 0 ? %{$("section#post-#{post.type}>div##{post.type}-default").remove();} : "") +
          %{$("section#post-#{post.type}>h3")} +
          %{.after("#{js_escape_html(partial('projects/post', locals: {project: project, post: post}))}");}
        )
        %{$("#post_#{type}_body").val('').focus();}
      else
        %{alert("creating post faled..");}
      end
    end

    delete type.to_sym, map: "/projects/:token/#{type}/:id", provides: :js do
      project = Project.where(token: params[:token]).first
      return 404 unless project

      post = project.posts.find(params[:id])
      if post.author == current_account
        post.destroy
        Pusher[project.token].trigger(
          "post-event",
          %{$("##{params[:id]}").remove();} +
            (project.posts.where(type: type).count <= 0 ? %{$("section#post-#{type}>h3").after("<div class='box' id='#{type}-default'><p>&nbsp;<p></div>");} : "")
        )
      end
    end

  end

end
