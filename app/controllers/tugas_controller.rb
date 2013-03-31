class TugasController < ApplicationController

  get "/tugas_1" do 
    haml :'tugas/1', :layout => false
  end
end