class UsersController < ApplicationController

    get '/login' do
        erb :'/users/login'
    end
  
    post '/login' do
      @user = User.find_by(:username => params[:username])
      if @user != nil && @user.password == params[:password]
        session[:user_id] = @user.id
        redirect to '/my_runs'
      else
        redirect to '/login'
      end
    end
  
    get '/signup' do
      erb :'/users/signup'
    end
  
    post '/signup' do
      
      @user = User.new(username: params[:username], email: params[:email], password: params[:password_digest])

      if @user.save
        session[:id] = @user.id
        redirect to '/runs'
        
      else
        @errors = @user.errors.full_messages
        erb :'users/signup'
      end
      
    end
  
    get '/logout' do
        binding.pry
      session.clear
      redirect to '/'
    end

end