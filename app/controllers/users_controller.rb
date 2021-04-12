class UsersController < ApplicationController
  before_action :set_user, only: %i[update destroy]
  before_action :authenticate, only: %i[update destroy]

  def index
    @users = User.all
    render json: @users
  end

  def new
    @user = User.create(username: params[:username], password: params[:password])
    if @user.save
      render json: { message: "welcome to the Venue_booking API #{@user.username}, you have successfully signed up." }
    else
      render json: { message: 'Invalid username or password.' }
    end
  end

  def update
    if !@user
      render json: { message: 'User with your provided id does not exist.' }
    elsif @current_user === @user
      if @user.update(username: params[:username], password: params[:password])
        render json: { message: 'Your account information was updated successfully.' }
      else
        render json: { message: 'Invalid username or password.' }
      end
    else
      render json: { message: "you are not authorized to edit other users' profile." }
    end
  end

  def destroy
    if !@user
      render json: { message: 'User with your provided id does not exist.' }
    elsif @current_user === @user
      @user.destroy
      render json: { message: 'Your account and all associated reservations have been successfully deleted.' }
    else
      render json: { message: "you are not authorized to delete other users' profile." }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    @user = nil
  end
end
