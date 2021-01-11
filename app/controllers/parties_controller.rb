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

  def show
    @party = Party.find(params[:id])
  end

  def edit
    @party = Party.find(params[:id])
    # if @party.save
    #   redirect_to root_path
    # end
  end

  def update
    @party = Party.find(params[:id])
    if @party.update(party_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @party = Party.find(params[:id])
    @party.destroy
    redirect_to root_path
  end

  private

  def party_params
    params.require(:party).permit(
      :name, :introduction, :season_id, :country_id, :genre_id, :image
    ).merge(user_id: current_user.id)
  end

end
