class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    any_error = true;
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      any_error = false
    end
    
    respond_to do |format|
      if !any_error
        format.html { redirect_to debts_path } 
      else
        format.html { redirect_to '/login', error: 'Incorrect Username or Password' }
      end
    end

    #   redirect_to '/welcome'
    # else
    #   redirect_to '/login'
    
  end

  def login
  end

  def welcome
    if(logged_in?)
      redirect_to '/debts'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/welcome'
  end
end
