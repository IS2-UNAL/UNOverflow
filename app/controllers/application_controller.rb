class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_i18n_locale_from_params
  protect_from_forgery with: :exception, prepend: true


 protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:name,:role,:avatar])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:alert] = "#{params[:locale]} translation not available"
        end
      end
    end

end
