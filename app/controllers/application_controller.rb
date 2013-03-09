class ApplicationController  < Application
  enable :sessions

  ['/matrikulasi', "/members"].each do |path|
    before path do
      session[:flash] = {type: 'warning', message: "Silahkan login Terlebih dahulu"}
      redirect '/' if session[:login].nil?
    end
  end

  get "/" do 
    haml :index, :layout => !request.xhr?
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
    haml :index, :layout => !request.xhr?
  end

  post "/logout" do
    session[:login] = nil
    redirect '/'
  end

  get "/matrikulasi" do
    @survei = Survei.new
    haml :matrikulasi
  end

  post '/matrikulasi' do
    @survei = Survei.new(params[:survei])
    if @survei.save
      session[:flash] = {type: 'success', message: "Terima kasih"}
    else
      session[:flash] = {type: 'error', message: @survei.errors.full_messages.join(", ")}
    end
  end

  get '/members' do
    haml :members
  end
end