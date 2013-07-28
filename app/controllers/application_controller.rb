require 'pg_tools'
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_tenant
  before_filter :authenticate_user!  
  before_filter :load_tuan
  
  rescue_from CanCan::AccessDenied do |exception| 
	 render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
  end
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  def routing
   render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  protected
  def load_tuan
    @current_week = 24
  end
  def load_tenant
    if @current_tenant ||= Tenant.last     
      PgTools.set_search_path @current_tenant.scheme    
    else
      PgTools.restore_default_search_path
    end
  end
  
end
