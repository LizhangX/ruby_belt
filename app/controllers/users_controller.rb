class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create, :index]
  def index
  end

  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      return redirect_to '/bright_ideas'
    else
      flash[:errors] = user.errors.full_messages
      return redirect_to :back
    end
  end

 
  def show
    @user = User.find(params[:id])   
  end

  private
    def user_params
      params.require(:user).permit(:name, :alias, :email, :password, :password_confirmation)
    end

    def auth
      return redirect_to '/bright_ideas' unless session[:user_id].to_s == params[:id]
    end
end
