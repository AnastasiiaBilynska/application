# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_no_athentication, only: %i[new create]
  before_action :require_athentication, only: %i[destroy]

  def new; end

  def create
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      sign_in(user)
      remember(user) if params[:remember_me] == '1'
      flash[:success] = "Welcome, #{current_user.name_or_email}!"
      redirect_to root_path
    else
      flash[:warning] = 'Incorrect email and/or password'
      redirect_to new_session_path
    end
  end

  def destroy
    sign_out
    flash[:success] = 'See you!'
    redirect_to root_path
  end
end
