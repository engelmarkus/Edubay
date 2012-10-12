# Verwaltet Sessions.
class SessionController < ApplicationController
  # Erstellt bei der Anmeldung eine neue Session.
  def create
    auth = request.env['omniauth.auth']
    user = User.find_by_uid(auth['uid']) || User.create_with_omniauth(auth)
    
    reset_session
    session[:user_id] = user.id
    
    redirect_to request.env['omniauth.origin'] || root_url, notice: 'Angemeldet!'
  end
  
  # Zerstört die aktuelle Session bei der Abmeldung.
  def destroy
    session[:user_id] = nil
    reset_session
    
    redirect_to root_url, notice: 'Abgemeldet!'
  end
end
