class UserSessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.find_by( email:params[:email] )
    if user && user.authenticate( params[:password] )
      session[:user_id] = user.id
      flash[:success] = "Authenticated successfully."
    else
      flash[:error] = "Authentication failed. Please check your username and password."
      render action: 'new'
    end
    
    redirect_to trips_path
  end
end
