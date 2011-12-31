#coding: utf-8

KptIt.controllers do

  get :index do
    if current_account
      redirect '/projects'
    else
      render :index
    end
  end

  get :logout do
    set_current_account(nil)
    redirect '/'
  end

  get '/auth/failure' do
    flash[:alert] = t('auth.failure')
    redirect '/'
  end

  %w[get post].each do |method|
    send(method, "auth/:provider/callback") do
      auth = request.env["omniauth.auth"]
      account = Account.where(provider: auth["provider"], uid: auth["uid"]).first || Account.create_with_omniauth(auth)
      set_current_account(account)
      redirect url(:index)
    end
  end

end
