class PartiesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :admin_user, only: [:new, :edit, :destroy]
  before_action :party_find, only: [:show, :edit, :update, :destroy]

  def index
    @party = Party.order("created_at DESC")
  end

  def new
    @party = Party.new
  end

  def create
    @party = Party.new(party_params)
    if @party.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @review = Review.new
    @reviews = @party.reviews.includes(:user)
  end

  def edit
  end

  def update
    if @party.update(party_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @party.destroy
    redirect_to root_path
  end


  private

  def party_params
    params.require(:party).permit(
      :name, :introduction, :season_id, :country_id, :genre_id, :official_url, :image
    ).merge(user_id: current_user.id)
  end

  def party_find
    @party = Party.find(params[:id])
  end

  def admin_user
    unless current_user.admin?
      redirect_to root_path 
    end
  end

end
