class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:edit]
  before_action :user_find, only: [:show, :edit, :update]

  def show
    @reviews = @user.reviews
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, dark: 'ユーザー情報の編集ができました'
    else
      flash[:danger] = 'ユーザー情報の編集ができませんでした'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :nickname, :gender_id, :genre_id, :profile
    ).merge(user_id: current_user.id)
  end

  def user_find
    @user = User.find(params[:id])
  end
end
