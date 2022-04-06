require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/space'
require_relative './database_connection_setup.rb'
require_relative './lib/user.rb'
require_relative './lib/database_connection.rb'

class MakersBNB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::Flash

  enable :sessions

  before do
    if session["user"].nil?
      if !%w[login user-auth].include? request.path_info.split("/")[1]
        redirect "/login"
      end
    end
  end

  get '/' do
    "This is a test"
  end

  get '/login' do
    erb :login
  end

  post '/user-auth' do
    p User.authenticate(params[:email], params[:password])
    if User.authenticate(params[:email], params[:password])
      session["user"] = params[:email]
      redirect '/spaces'
    else
      redirect "/login"
      # flash message
    end
  end

  get '/spaces' do
    @space = Space.all
    erb :spaces
  end

  get '/new-space' do
    erb :newspace
  end

  post '/new-space' do
    DatabaseConnection.query(
      "INSERT INTO spaces (name, description, price_per_night) VALUES ($1,$2,$3);",
      [params[:name], params[:description], params[:price_per_night]]
    )
    redirect '/spaces'
  end

  run! if app_file == $0
end
