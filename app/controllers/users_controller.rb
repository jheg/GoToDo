class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show]
  before_action :set_profile, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'Thanks for registering - You are now logged in'
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    @editable = true
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'Account updated'
      redirect_to user_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :first_name, :last_name)
  end

  def set_user
    @user = current_user
  end

  def set_profile
    @profile = User.find(params[:id])
  end

  def require_same_user
    if current_user != @profile
      flash[:error] = 'You cannot do that'
      redirect_to root_path
    end
  end


end