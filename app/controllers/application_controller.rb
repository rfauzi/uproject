class ApplicationController  < Application

  get "/" do 
    puts session[:current_user]
    haml :index
  end

  get "/channel" do
    haml :channel
  end

  post "/facebook_auth" do
    puts params
    @user = User.where(:id => params[:uid]).first
    if @user.present?
      session[:current_user] = @user
    else
      @success = User.register_facebook(params)
      @user = User.where(:id => params[:uid]).first
      session[:current_user] = @user
    end

  end


end