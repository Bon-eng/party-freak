class UsersController < ApplicationController


  def index
    @reviews = @user.reviews
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

end
