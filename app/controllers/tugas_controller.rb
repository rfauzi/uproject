class TugasController < Application

  get "/tugas_1" do 
    haml :'tugas/tugas_1', :layout => false
  end
end