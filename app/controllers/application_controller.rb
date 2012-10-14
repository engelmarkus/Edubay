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
    logged_in? and Edubay::Application.config.admin_ids.include?(current_user)
  end
  
  # Rendert eine Fehlermeldung, wenn dem Benutzer der Zugriff auf eine Seite verweigert wurde.
  def access_denied
    respond_to do |format|
      format.html {
        flash[:error] = "Sie sind nicht angemeldet oder nicht berechtigt, auf die angeforderte Seite zuzugreifen."
        render text: "", layout: true, status: :unauthorized
      }
      
      format.any {
        head status: :unauthorized
      }
    end
  end
  
  # Leitet um, falls der Benutzer nicht angemeldet ist und eine geschützte Seite öffnen möchte.
  def redirect_if_not_logged_in
    if logged_in? then
      return true
    else
      # Es findet kein wirkliches "redirect_to" statt, da sonst die URL verloren geht, die der Benutzer
      # ursprünglich sehen wollte. Dies könnte verwirren, wenn nach erfolgreichem Login trotzdem auf die
      # Access Denied-Seite umgeleitet werden würde.
      access_denied
    end
  end
  
  # Leitet um, falls der Benutzer nicht angemeldet bzw. kein Administrator ist und
  # eine geschützte Seite öffnen möchte.
  def redirect_if_not_admin
    if admin? then
      return true
    else
      access_denied
    end
  end
end
