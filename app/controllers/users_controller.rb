class UsersController < ApplicationController
  before_action :require_no_athentication, only: %i[new create]
  before_action :require_athentication, only: %i[edit update]
  before_action :set_user!, only: %i[edit update]

  def new
    @user = User.new
  end

  def edit
    if @user.update user_params
      flash[:success] = "Your profile was successfully updated!"
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  def update
    @user = User.new
  end
  def create
    @user = User.new user_params
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to the application, #{current_user.name_or_email}!"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def set_user!
    user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, )
  end
end