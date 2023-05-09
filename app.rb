# file: app.rb
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/user_repository'
require_relative 'lib/post_repository'


DatabaseConnection.connect('chitter_challenge_test')

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/user_repository'
    also_reload 'lib/post_repository'
  end

  get '/' do
    return erb(:index)
  end

  get '/login' do
    return erb(:login)
  end

  # post '/login' do
  #   return erb(:shoutybox)
  # end

  get '/signup' do
    return erb(:signup)
  end

  get '/shoutybox' do
    posts = PostRepository.new
    @users = UserRepository.new

    @peeps = posts.all.reverse

    return erb(:shoutybox)
  end


end