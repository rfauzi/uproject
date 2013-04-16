class CoursesController < ApplicationController

  ['/courses/create', "/courses/new", "/courses", "/courses/delete"].each do |path|
    before path do
      if current_user.nil?
        session[:flash] = {type: 'warning', message: "Silahkan login Terlebih dahulu"} 
        redirect '/' 
      end
    end
  end

  get '/courses' do 
    @courses = Course.all
    haml :'courses/index'
  end

  get '/courses/:id' do
    @course = Course.where(id: params[:id]).first
    haml :'courses/show'
  end

  post '/courses/create' do 
    @course = Course.new(params[:course])
    if @course.save
      session[:flash] = {type: 'success', message: "Berhasil membuat kursus baru"}
    else
      session[:flash] = {type: 'error', message: "Gagal membuat kursus baru"}
    end
  end

end