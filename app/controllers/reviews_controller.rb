class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :destroy]
  before_action :review_find, only: [:show, :update, :edit, :destroy]

  def index
    @reviews = @user.reviews
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to party_path(@review.party), notice: 'レビューの投稿ができました。'
    else
      @party = Party.find(params[:party_id])
      @reviews = @party.reviews.includes(:user)
      flash[:error] = 'レビューの投稿ができませんでした。'
      render 'parties/show'
    end
  end

  def edit
    redirect_to root_path, alert: '無効なURLです' unless current_user.id == @review.user_id
  end

  def update
    if @review.update(review_params)
      redirect_to party_path(@review.party), notice: 'レビューの編集ができました。'
    else
      flash[:error] = 'レビューの編集ができませんでした。'
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to party_path(@review.party), alert: 'レビューの削除ができました。'
  end

  def show
    @party = Party.find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(
      :title, :content, :image
    ).merge(user_id: current_user.id, party_id: params[:party_id])
  end

  def review_find
    @review = Review.find(params[:id])
  end
end
