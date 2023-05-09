require "spec_helper"
require "rack/test"
require_relative '../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  def reset_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_challenge_test' })
    connection.exec(seed_sql)
  end
  

  describe Application do
    before(:each) do 
      reset_table
    end
  end

  context 'GET /' do
    it 'returns html homepage' do
        response = get('/')
        
        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>Welcome to Chitter</h1>')
        expect(response.body).to include('<a href="/login">Login</a><br>')
        expect(response.body).to include('<a href="/signup">Signup</a><br>')
        expect(response.body).to include('<a href="/shoutybox">Shouty Box<br>- see what people are peeping</a>')
    end
  end

  context 'GET /login' do
    it 'returns login page' do
        response = get('/login')

        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>Login</h1>')
        expect(response.body).to include('<form action="/login" method="POST">')
        expect(response.body).to include('<input type="text" name="email">')
        expect(response.body).to include('<input type="text" name="password">')
    end
  end

  context 'GET /signup' do
    it 'returns signup page' do
        response = get('/signup')

        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>Signup</h1>')
        expect(response.body).to include('<input type="text" name="name">')        
        expect(response.body).to include('<input type="text" name="username">')
        expect(response.body).to include('<input type="text" name="email">')
        expect(response.body).to include('<input type="text" name="password">')
    end
  end

end