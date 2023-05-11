# file: app.rb
require 'sinatra/base'
require 'sinatra/reloader'
require 'time'
require_relative 'lib/database_connection'
require_relative 'lib/user_repository'
require_relative 'lib/post_repository'


DatabaseConnection.connect

class Application < Sinatra::Base
  enable :sessions

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

  post '/login' do
    email = params[:email]
    password = params[:password]
    repo = UserRepository.new
    user = repo.find_by_email(email)

    login_result = repo.sign_in(email, password)

    if login_result == true
      session[:user_id] = user.id
      return erb(:login_success)
    else
      return erb(:login_error)
    end

### demo version withou encrypted passwords
    # email = params[:email]
    # password = params[:password]
    # repo = UserRepository.new
    # user = repo.find_by_email(email)

    # # This is a simplified way of 
    # # checking the password. In a real 
    # # project, you should encrypt the password
    # # stored in the database.
    # if password == user.password
    #   # Set the user ID in session
    #   session[:user_id] = user.id

    #   return erb(:login_success)
    # else
    #   return erb(:login_error)
    # end
  end

  get '/account_page' do
    @user = session[:user_id]
    if session[:user_id] == nil
      return redirect('/login')
    else
      return erb(:account)
    end
  end

  get '/signup' do
    return erb(:signup)
  end

  post '/signup' do
    users = UserRepository.new
    new_user = User.new

    new_user.name = params[:name]
    new_user.username = params[:username]
    new_user.email = params[:email]
    new_user.password = params[:password]

    users.create(new_user)

    return erb(:signup_confirmation)
  end

  get '/shoutybox' do
    posts = PostRepository.new
    @users = UserRepository.new

    @peeps = posts.all.reverse

    return erb(:shoutybox)
  end

  get '/peep/new' do
    return erb(:peep_new)
  end

  post '/peep' do
    posts = PostRepository.new
    new_post = Post.new

    new_post.peep = params[:peep]
    new_post.time = Time.now
    new_post.user_id = session[:user_id]
    
    posts.create(new_post)

    return erb(:peep_confirmation)
  end

  def invalid_request_parameters?
    return (params[:title] == nil || params[:release_year] == nil || 
    params[:artist_id] == nil)
  end
end

