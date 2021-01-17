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


  private

  def review_params
    params.require(:review).permit(
      :title, :content, :score, :image
    ).merge(user_id: current_user.id, party_id: params[:party_id])
  end

end
