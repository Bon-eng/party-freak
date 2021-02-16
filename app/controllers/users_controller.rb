class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:edit]
  before_action :user_find, only: [:show, :edit]

  def show
    @reviews = @user.reviews
  end

  def edit
    unless current_user.id == @user.id
      redirect_to root_path
      flash[:error] = '無効なURLです'
    end
  end

  private

  def user_find
    @user = User.find(params[:id])
  end
end
