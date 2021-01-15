class Administrator::PartiesController < ApplicationController

  before_action :admin_user
 
  def index
    @parties = Party.all.order(created_at: :desc)
  end
  
  private
    def admin_user
      redirect_to(root_url) unless current_user.administrator?
    end
end
