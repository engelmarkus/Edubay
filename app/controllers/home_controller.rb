class HomeController < ApplicationController
  def index
  end

  def intro
  end
  
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
end
