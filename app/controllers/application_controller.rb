class ApplicationController < Application

  ['/matrikulasi', "/members", "/profile", "/download", "/message"].each do |path|
    before path do
      if current_user.nil?
        session[:flash] = {type: 'warning', message: "Silahkan login Terlebih dahulu"} 
        redirect '/' 
      end
    end
  end

  get "/" do 
    @messages = Message.all
    haml :index, :layout => !request.xhr?
  end

  get "/channel" do
    haml :channel
  end

  post "/facebook_auth" do
    # @user = User.where(:uid => params[:uid]).first
    @user = User.first
    unless @user.present?
      @success = User.register_facebook(params)
      @user = User.where(:uid => params[:uid]).first
    end

    session[:login] = @user
    @messages = Message.all
    haml :index, :layout => !request.xhr?
  end

  post "/logout" do
    session.clear
    redirect '/'
  end


  post '/message' do
    redirect '/' if !request.xhr?
    @message = current_user.messages.new(message: params[:message])
    @message.save
    haml :message, :layout => false
  end

  get '/download' do
    redirect '/' unless params[:t].present?
    @download_links = DownloadLink.where(link_type: params[:t]) unless params[:t] == "source_code"
    haml :'download/index'
  end

  post '/download' do
    puts params[:download_link]
    @download_link = DownloadLink.new(params[:download_link])
    if @download_link.save
      session[:flash] = {type: 'success', message: "Data berhasil disimpan"}
    else
      session[:flash] = {type: 'error', message: @download_link.errors.full_messages.join(", ")}      
    end
    redirect '/download'
  end

  
end