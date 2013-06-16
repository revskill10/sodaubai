class DashboardController < ApplicationController
  
  before_filter :load_lops
  def index

  end
  
  protected
  def load_lops
  	@current_lops = [] unless current_user.imageable  	
  	@current_lops = current_user.imageable.lop_mon_hocs if current_user.imageable	    
  end
end
