class ApplicationController  < Application
  enable :sessions

  get "/" do 
    haml :index
  end

  get "/channel" do
    haml :channel
  end

  post "/facebook_auth" do
    @user = User.where(:uid => params[:uid]).first
    unless @user.present?
      @success = User.register_facebook(params)
      @user = User.where(:uid => params[:uid]).first
    end

    session[:login] = @user
  end

  post "/logout" do
    session[:login] = nil
    redirect '/'
  end

end