class ReviewsController < ApplicationController

  before_action :review_find, only: [:show, :update, :destroy]

  def index
    @reviews = @user.reviews
  end

  def create
    @review = Review.new(review_params)
    # @review = Party.find(params[:party_id])
    # @reviews = @party.reviews.includes(:user)
    if @review.save
      redirect_to party_path(@review.party)
    else
      render "parties/show"
    end
  end

  def edit
    # @party = Party.find(params[party.id])
    @review = Review.find(params[:id])
  end

  def update
    if @review.update(review_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to root_path
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
