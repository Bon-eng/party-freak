class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      redirect_to @user, notice: 'ユーザー情報の編集ができました。'
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
    else
      flash[:error] = 'ユーザー情報の編集ができませんでした。'
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:nickname, :gender_id, :profile, :genre_id])
  end
end
