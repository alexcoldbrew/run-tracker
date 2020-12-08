class RunsController < ApplicationController

    
    get '/runs/new' do
        erb :new
    end
  
    get "/" do
      erb :index
    end
  
    get '/runs' do
      if logged_in?
        @runs = current_user.runs
        erb :show
      else
        redirect '/login'
      end
    end
  
    post '/runs' do
      # add validations
      # if params[:distance].empty?
      
      @runs = current_user.runs
      @run = Run.new(params)
      @run.user_id = session[:user_id]
      @run.save
      erb :show
    end
  
    post '/runs/new' do
      if logged_in?
        @run = Run.new(params)
        @run.user_id = session[:user_id]
        @run.save
        erb :show
      else
        redirect to '/login'
      end
    end
  
    get '/runs/:id' do
      if logged_in?
        @run = Run.find_by_id(params[:id])
        erb :show
      else
        redirect to '/login'
      end
    end
  
    get '/runs/:id/edit' do
      @run = Run.find_by_id(params[:id])
      if logged_in?
        erb :edit
      else
        redirect to '/login'
      end
    end
  
    patch '/runs/:id' do
      @run = Run.find_by_id(params[:id])
      if logged_in?
        @run.date = params[:date]
        @run.distance = params[:distance]
        @run.hours = params[:hours]
        @run.minutes = params[:minutes]
        @run.seconds = params[:seconds]
        @run.save
        redirect to '/runs'
      else
        redirect to '/login'
      end
    end
  
    delete '/runs/:id/delete' do
      @run = Run.find_by_id(params[:id])
      if logged_in?
        @run.destroy
      end
      redirect to '/runs'
    end


end