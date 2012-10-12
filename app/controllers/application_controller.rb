# coding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :logged_in?, :current_user, :admin?
  
  protected
  
  # Gibt den aktuellen angemeldeten Benutzer oder nil zurück
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  # Gibt zurück, ob der Benutzer angemeldet ist.
  def logged_in?
    current_user != nil
  end
  
  # Gibt true zurück, wenn der aktuell angemeldete Benutzer ein Administrator ist.
  def admin?
    return false
  end
  
  # Leitet um, falls der Benutzer nicht angemeldet ist und eine geschützte Seite öffnen möchte.
  def redirect_if_not_logged_in
    if logged_in? then
      return true
    else
      redirect_to home_access_denied_url
    end
  end
  
  # Leitet um, falls der Benutzer nicht angemeldet bzw. kein Administrator ist und
  # eine geschützte Seite öffnen möchte.
  def redirect_if_not_admin
    if admin? then
      return true
    else
      redirect_to home_access_denied_url
    end
  end
end
