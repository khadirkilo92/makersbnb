require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/space'
require_relative './database_connection_setup.rb'

class MakersBNB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::Flash

  enable :sessions

  before do
    pass if %w[login].include? request.path_info.split("/")[1] ||  !session["user"].nil?
    redirect "/login"
  end

  get '/' do
    "This is a test"
  end

  get '/login' do
    erb :login
  end

  post '/user-auth' do
    if User.authenticate(params[:email], params[:password])
      session["user"] = params[:email]
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
