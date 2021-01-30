class ReviewsController < ApplicationController

  def index
    @reviews = @user.reviews
  end

  def create
    @review = Review.new(review_params)
    @party = Party.find(params[:party_id])
    @reviews = @party.reviews.includes(:user)
    if @review.save
      redirect_to party_path(@review.party)
    else
      render "parties/show"
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to root_path
  end

  

  def show
    @review = Review.find(params[:id])
    @party = Party.find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(
      :title, :content, :image
    ).merge(user_id: current_user.id, party_id: params[:party_id])
  end

end
