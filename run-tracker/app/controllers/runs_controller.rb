class RunsController < ApplicationController

    
    get '/runs/new' do
        if logged_in?
            erb :'/runs/new'
        else
            redirect '/login'
        end
    end
  
  
    get '/runs' do
      if logged_in?
        @runs = current_user.runs
        @runs = Run.all
        erb :'/runs/index'
      else
        redirect '/login'
      end
    end


    post '/runs' do
        if logged_in?
            @runs = current_user.runs
            @run = Run.new(params)
            @run.user_id = session[:user_id]

            total = params[:hours].to_i + params[:minutes].to_i + params[:seconds].to_i
            if @run.save && total != 0
                redirect to "/runs/#{@run.id}"
            else
                if total == 0   
                    flash[:message] = "Run duration cannot be 0!!!"
                    erb :'/runs/new' 
                else
                    @errors = @run.errors.full_messages
                    erb :'/runs/new' 
                end
            end
        end
    end
  
    get '/runs/:id' do
      if logged_in? && @run = Run.find_by_id(params[:id])   
        @user = @run.user
        erb :'/runs/show'
      else
        redirect to '/login'
      end
    end
  
    get '/runs/:id/edit' do
      
      if logged_in? && @run = Run.find_by_id(params[:id])
        
        if @run.user_id == session[:user_id]
            erb :'/runs/edit'
        else
            redirect to '/login'
        end
    else
        redirect to :error
        
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
        redirect to '/my_runs'
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

    get '/my_runs' do
        if logged_in?
            @runs = current_user.runs
            erb :'/runs/my_runs'
        else
            redirect to '/login'
        end
    end

end