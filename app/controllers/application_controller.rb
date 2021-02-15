class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  add_flash_types :danger, :dark

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :gender_id, :profile, :genre_id])
  end

end
