class ApplicationController  < Application

  get "/" do 
    haml :index
  end

  get "/channel" do
    haml :channel
  end
end