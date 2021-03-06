class UsersController < ApplicationController

    get '/login' do
        erb :'/users/login'
    end
  
    post '/login' do
      @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/my_runs'
      else
        flash.now[:message] = "Invalid credentials"
        
        erb :'/users/login'
      end
    end
  
    get '/signup' do
      erb :'/users/signup'
    end
  
    post '/signup' do
      
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])

      if @user.save
        session[:id] = @user.id
        redirect to '/runs'
        
      else
        @errors = @user.errors.full_messages
        erb :'users/signup'
      end
      
    end
  
    get '/logout' do
      session.clear
      redirect to '/'
    end

end