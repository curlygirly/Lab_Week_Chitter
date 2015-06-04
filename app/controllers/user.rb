get '/users' do
  @user = User.new
  erb: 'users'

end

post '/users' do
  @user = User.new(name: params[:name],
                        username: params[:username],
                        email: params[:email],
                        password: params[:password],
                        password_confirmation: params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.user_id
    redirect to('/')
