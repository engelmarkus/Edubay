class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # Setzt die Locale.
  before_filter :set_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def default_url_options(options = {})
    { locale: I18n.locale }
  end
  
  helper_method :current_user
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
