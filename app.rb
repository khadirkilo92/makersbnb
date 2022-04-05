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

  get '/' do
    "This is a test"
  end

  get '/spaces' do
    @space = Space.all
    erb :spaces
  end

  run! if app_file == $0
end
