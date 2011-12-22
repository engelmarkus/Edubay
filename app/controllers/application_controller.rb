class ApplicationController < ActionController::Base
  protect_from_forgery
  #after_filter :flash_to_headers
  #
  #def flash_to_headers
  #  #return unless request.xhr?
  #  
  #  #response.headers['X-Message'] = flash_message
  #  response.headers['X-Message'] = "huhu"
  #  #response.headers['X-Message-Type'] = flash_type
  #  
  #  #flash.discard
  #end
  #
  #private
  #
  #def flash_message
  #  [:error, :warning, :notice].each do |type|
  #    return flash[type] unless flash[type].blank?
  #  end
  #end
  #
  #def flash_type
  #  [:error, :warning, :notice].each do |type|
  #    return type unless flash[type].blank?
  #  end
  #end
  
  before_filter :set_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def default_url_options(options = {})
    { :locale => I18n.locale }
  end
end
