class RunsController < ApplicationController

    
    get '/runs/new' do
        erb :'/runs/new'
    end
  
    get "/" do
      erb :'/runs/index'
    end
  
    get '/runs' do
      if logged_in?
        @runs = current_user.runs
        erb :'/runs/show'
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
      erb :'runs/show'
    end
  
    post '/runs/new' do
      if logged_in?
        @run = Run.new(params)
        @run.user_id = session[:user_id]
        @run.save
        erb :'/runs/show'
      else
        redirect to '/login'
      end
    end
  
    get '/runs/:id' do
      if logged_in?
        @run = Run.find_by_id(params[:id])
        erb :'/runs/show'
      else
        redirect to '/login'
      end
    end
  
    get '/runs/:id/edit' do
      
      if logged_in?
        @run = Run.find_by_id(params[:id])
        if @run.user_id == session[:user_id]
            erb :'/runs/edit'
        else
            # flash an error message
            redirect to '/login'
        end
      end
    end
  
    patch '/runs/:id' do
      @run = Run.find_by_id(params[:id])
      # utilize authorized user helper to stop from going to (or at least updating) another user's run
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