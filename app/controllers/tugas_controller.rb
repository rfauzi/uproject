class TugasController < Application

  get "/tugas_1" do 
    haml :'tugas/tugas_1', :layout => false
  end

  get "/tugas_2" do
    haml :'tugas/tugas_2', :layout => false
  end
end