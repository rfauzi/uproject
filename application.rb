require 'sinatra'
require 'haml'
require "sinatra/activerecord"
require './app/helpers/uproject'

class Application
  %w(models controllers helpers).map { |p| Dir.glob("#{Dir.pwd}/app/#{p}/*.rb") { |m| require "#{m.chomp}" }}
  configure :development, :test do
    set :database, "sqlite3:///uproject.db"
  end

  configure :production do
    # Database connection
    db = URI.parse(ENV['DATABASE_URL'])

    ActiveRecord::Base.establish_connection(
      :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
    )
  end

  configure do
    set :protection, :except => [:http_origin]
    use Rack::Protection::HttpOrigin, :origin_whitelist => ['http://ebr.web.id/kursus']

    set :method_override, true 
    set :views, settings.root + '/app/views'
    set :public_folder, settings.root + "/app/assets"    
    
    app_setting = YAML.load_file("#{Dir.pwd}/config/app_secret.yml")[Sinatra::Base.environment.to_s]
    set :super_admin_uid, app_setting['admin_uid']['super']
    set :admin_uids, app_setting['admin_uid']['manager']
    set :facebook_app_id, app_setting['facebook']['app_id']

    use Rack::Session::Pool, :key => 'rack.session'
  end

end
