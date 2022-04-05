require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
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

  run! if app_file == $0
end
