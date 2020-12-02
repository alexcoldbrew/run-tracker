class UsersController < ApplicationController

    post '/login' do
        @user = User.find_by_id(:username => params[:username])
        if @user != nil && @user.password == params[:password]
          session[:user_id] = @user.id
          redirect to '/account'
        end
        erb :error
      end
    
      get '/account' do
        @current_user = User.find_by_id(session[:user_id])
        if @current_user
          erb:account
        else
          erb :error
        end
      end
    
      get '/logout' do
        session.clear
        redirect to '/'
      end

end