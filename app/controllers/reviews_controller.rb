class ReviewsController < ApplicationController

  before_action :review_find, only: [:show, :update, :edit, :destroy]

  def index
    @reviews = @user.reviews
  end

  def create
    @review = Review.new(review_params)
    # @review = Party.find(params[:party_id])
    # @reviews = @party.reviews.includes(:user)
    if @review.save
      redirect_to party_path(@review.party), dark: 'レビューの投稿ができました'
    else
      flash[:danger] = 'レビューの投稿ができませんでした'
      render "parties/show"
      # redirect_to party_path(@review.party)
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to party_path(@review.party), dark: 'レビューの編集ができました'
    else
      flash[:danger] = 'レビューの編集ができませんでした'
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to party_path(@review.party), danger: 'レビューの削除ができました'
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
