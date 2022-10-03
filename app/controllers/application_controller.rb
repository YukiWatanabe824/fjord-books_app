# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name address introduction post_code])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name address introduction post_code])
  end

  def after_sign_up_path_for
    root_path
  end
end
