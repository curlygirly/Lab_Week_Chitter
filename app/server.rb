require 'sinatra/base'
require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/Chitter_#{env}")

require_relative './models/peep'
require_relative './models/user'
require_relative './controllers/user'

DataMapper.finalize
DataMapper.auto_upgrade!

class Chitter < Sinatra::Base
  get '/' do
    'Hello Chitter!'
    # erb :index
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
