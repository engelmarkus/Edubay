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
  
  helper_method :logged_in?, :current_user, :admin?
    
  protected

  # Returns the currently logged in user or nil
  def current_user
    @current_user = User.new
    return @current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Returns whether the user is logged in.
  def logged_in?
    current_user != nil
  end
  
  # Returns true if the currently logged in user is an admin.
  def admin?
    return true
  end
  
  def redirect_if_not_logged_in
    if logged_in? then
      return true
    else
      redirect_to root_url
    end
  end
  
  def redirect_if_not_admin
    if admin? then
      return true
    else
      redirect_to root_url
    end
  end
end
