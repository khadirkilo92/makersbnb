require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/space'
require './lib/booking'
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
      if !%w[login user-auth signup new-user].include? request.path_info.split("/")[1]
        redirect "/login"
      end
    end
  end

  get '/' do
    erb :index
  end

  get '/login' do
    erb :login
  end

  post '/user-auth' do
    if User.authenticate(params[:email], params[:password])
      session["user"] = params[:email]
      redirect '/spaces'
    else
      flash[:notice] = "The email or password you entered are incorrect"
      redirect "/login"
    end
  end

  get '/signup' do
    erb :signup
  end

  post '/new-user' do
    if User.valid_email(params["email"])
      User.add(params["email"], params["password"])
      redirect '/login'
    else 
      flash[:notice] = "Please enter a valid email address"
      redirect '/signup'
    end
  end

  get '/spaces' do
    @username = session["user"]
    @space = Space.all
    erb :spaces
  end

  get '/new-space' do
    @username = session["user"]
    erb :newspace
  end

  post '/new-space' do
    DatabaseConnection.query(
      "INSERT INTO spaces (name, description, price_per_night) VALUES ($1,$2,$3);",
      [params[:name], params[:description], params[:price_per_night]]
    )
    redirect '/spaces'
  end

  get '/booking_preview/:id' do
    @username = session["user"]
    @bookedspace = Space.find(id: params[:id])
    if params["duration"].nil? 
      params["duration"] = 1 
    end
    @duration = params["duration"]
    erb :booking_preview
  end

  post '/calculate' do
    redirect "/booking_preview/#{params[:id]}?duration=#{params["number_of_nights"]}"
  end
  
  get '/booking_confirmation' do
    @username = session["user"]
    erb :booking_confirmation
  end

  run! if app_file == $0
end
