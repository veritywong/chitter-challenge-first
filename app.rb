# file: app.rb
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'


DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    # also_reload 'lib/album_repository'
    # also_reload 'lib/artist_repository'
  end
end