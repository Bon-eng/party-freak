class UsersController < ApplicationController
  # before_action :authenticate_user!, only: [:edit]
  before_action :user_find, only: [:show, :edit]

  def show
    @reviews = @user.reviews
  end

  def edit
    redirect_to root_path, alert: '無効なURLです' unless current_user.id == @user.id
  end

  private

  def user_find
    @user = User.find(params[:id])
  end
end
