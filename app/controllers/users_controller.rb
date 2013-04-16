class UsersController < ApplicationController

  get '/members' do
    haml :members
  end

  get '/profile' do
    @profile = current_user.profile.present? ? current_user.profile : current_user.build_profile
    haml :profile
  end

  post '/profile' do
    @profile = current_user.build_profile(params[:profile])
    if @profile.save
      session[:flash] = {type: 'success', message: "Terima kasih"}
    else
      session[:flash] = {type: 'error', message: @profile.errors.full_messages.join(", ")}      
    end
    redirect '/profile'
  end

  get "/matrikulasi" do
    if current_user.profile.present?
      @survei = current_user.survei.present? ? current_user.survei : current_user.build_survei
      haml :matrikulasi      
    else
      session[:flash] = {type: 'warning', message: "Silahkan isi profile terlebih dahulu"}
      redirect '/profile'
    end
  end

  post '/matrikulasi' do
    puts params[:matrikulasi]
    redirect '/profile' unless current_user.profile.present?
    @survei = current_user.build_survei(params[:matrikulasi])
    if @survei.save
      session[:flash] = {type: 'success', message: "Terima kasih"}
      redirect '/'
    else
      session[:flash] = {type: 'error', message: @survei.errors.full_messages.join(", ")}
      redirect '/matrikulasi'
    end
  end
  
end