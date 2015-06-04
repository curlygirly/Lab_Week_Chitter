require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/Chitter_#{env}")

require_relative './models/peep'
require_relative './models/user'


DataMapper.finalize
DataMapper.auto_upgrade!

class Chitter < Sinatra::Base

  enable :sessions
  use Rack::Flash
  use Rack::MethodOverride


  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id]) if session[:user_id]
    end
  end

  get '/' do
    @peep = Peep.all
    erb :index
  end

  get '/user/new' do
    @user = User.new
    erb :'user/new'
  end

  post '/user' do
    @user = User.new(name: params[:name],
                          username: params[:username],
                          email: params[:email],
                          password: params[:password],
                          password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'user/new'
    end
  end

  get '/session/new' do
    erb :'session/new'
  end

  post '/session' do
    email, password = params[:email], params[:password]
    user = User.authenticate(email, password)
    if user
      session[:user_id] = user.id
    redirect '/'
    else
      session[:user_id] = nil
      redirect '/'
    end
  end

  post '/peep' do
    if current_user
      message = params[:message]
      @peep = Peep.create(message: message, username: current_user.username, name: current_user.name)
      redirect '/'
    else
      redirect '/'
    end
  end

   delete '/session' do
      session[:user_id] = nil
      redirect to('/')
  end
end
