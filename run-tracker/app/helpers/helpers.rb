require 'sinatra/base'

class Helpers

  def self.current_user(session)
    @user = User.find_by_id(session[:user_id])
  end

  def self.is_logged_in?(session)
    !!session[:user_id]
  end

  def authorized_user?(session)
    @run = Run.find_by_id(params[:id])
    if @run.user_id == session[:user_id]
    end
  end
end