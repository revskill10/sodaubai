class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!  
  rescue_from CanCan::AccessDenied do |exception| 
	 render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
  end
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  def routing
   render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
