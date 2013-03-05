require 'sinatra'
require 'haml'
require 'pony'
require 'mongo'
require 'uri'
require './app/helpers/uproject'

enable :sessions

class Application
  %w(models controllers helpers).map { |p| Dir.glob("#{Dir.pwd}/app/#{p}/*.rb") { |m| require "#{m.chomp}" }}
  configure do
    set :method_override, true 
    set :views, settings.root + '/app/views'
    set :public_folder, settings.root + "/app/assets"
  end
end