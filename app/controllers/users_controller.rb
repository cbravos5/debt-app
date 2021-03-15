class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    parameters = user_params
    @user = User.new(parameters)
    is_saved = @user.save
    set_session

    respond_to do |format|
      if is_saved
        format.html { redirect_to debts_path, notice: "User was successfully created." } 
      else
        format.html { render :new }
      end
    end

  end

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end

    def set_session
      session[:user_id] = @user.id
    end
end
