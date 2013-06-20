[:user, :message, :profile].each do |x|
  objects =  YAML.load_file("#{Dir.pwd}/db/seeds/#{x}.yml")
  objects.each do |o|
    x.to_s.titleize.constantize.new(o[1]).save
  end
end

