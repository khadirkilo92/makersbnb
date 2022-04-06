require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/space'
require './lib/booking'
require_relative './database_connection_setup.rb'

class MakersBNB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::Flash

  enable :sessions

  get '/' do
    "This is a test"
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

  get '/booking_preview/:id' do
    @bookedspace = Space.find(id: params[:id])
    erb :"booking_preview"
  end
  
  get '/booking_confirmation' do
  end

  run! if app_file == $0
end
