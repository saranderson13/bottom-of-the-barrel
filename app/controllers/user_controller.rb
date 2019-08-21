class UserController < ApplicationController

  get '/users' do
    @users = User.all
    @recipes = Recipe.all
    erb :'/users/all_users'
  end

  get '/users/:id' do
    if object_exists?("User", params[:id])
      @user = User.find(params[:id])
      erb :'/users/profile'
    else
      # User does not exist.
      redirect '/home'
    end
  end

  get '/users/:id/edit' do
    if object_exists?("User", params[:id])
      @user = User.find(params[:id])
      if authenticated_user?(@user)
        erb :'/users/edit_profile'
      else
        # You do not have permission to edit that user.
        redirect '/home'
      end
    else
      # User does not exist.
      redirect '/home'
    end
  end

  patch '/users/:id' do
    @user = User.find(params[:id])
    if authenticated_user?(@user)
      @user.update(name: params[:name])
      redirect "/users/#{@user.id}"
    else
      redirect '/home'
    end
  end

  delete '/users/:id' do
    @user = User.find(params[:id])
    if authenticated_user?(@user)
      @user.destroy
      session.clear
      redirect '/home'
    else
      redirect '/home'
    end
  end

end
