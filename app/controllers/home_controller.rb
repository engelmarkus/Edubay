class HomeController < ApplicationController
  def index
    @recently_uploaded_files = Document.find(:all, :order => 'created_at DESC', :limit => 10)
  end
  
  def intro
  end
end
