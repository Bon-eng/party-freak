class PartiesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :admin_user, only: [:new, :edit, :destroy]
  before_action :party_find, only: [:show, :edit, :update, :destroy]

  def index
    @party = Party.order("created_at DESC")
    @review = Review.order("created_at DESC")
  end

  def new
    @party = Party.new
  end

  def create
    @party = Party.new(party_params)
    if @party.save
      redirect_to @party, notice: 'Partyの投稿ができました。'
    else
      flash[:error] = 'Partyの投稿ができませんでした。'
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
      redirect_to @party, notice: 'Partyの編集ができました。'
    else
      flash[:error] = 'Partyの編集ができませんでした。'
      render :edit
    end
  end

  def destroy
    @party.destroy
    redirect_to root_path
    flash[:error] = 'Partyの削除ができました。'
  end

  def lineup
    @party = Party.order("created_at DESC").page(params[:page]).per(9)
  end

  def search
    @parties = Party.search(params[:keyword])
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
      redirect_to root_path, alert: '無効なURLです。'
    end
  end

end
