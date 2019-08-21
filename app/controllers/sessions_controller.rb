class SessionsController < ApplicationController

  get '/signup' do
    redirect '/home' if logged_in?
    erb :'/sessions/signup'
  end

  post '/signup' do
    @user = User.create(name: params[:name], username: params[:username], password: params[:password])
    if @user.errors.any?
      erb :'/sessions/signup'
    else
      session[:user_id] = @user.id
      redirect "/users/#{ @user.id }"
    end
  end

  get '/login' do
    redirect '/home' if logged_in?

    @login_fail = false
    erb :'/sessions/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if !!user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/home'
    else
      @login_fail = true
      erb :'sessions/login'
    end
  end

  post '/logout' do
    session.clear
    redirect '/home'
  end
end
