class PartiesController < ApplicationController

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

  private

  def party_params
    params.require(:party).permit(
      :name, :introduction, :season_id, :country_id, :genre_id, :image
    ).merge(user_id: current_user.id)
  end

end
