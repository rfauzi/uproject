class ApplicationController  < Application

  get "/" do 
    haml :index
  end
end