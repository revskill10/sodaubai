class DashboardController < ApplicationController
  
  before_filter :load_lops
  def index    
  
  end
  def show
  
  end
  
  protected
  def load_lops
    @type = current_user.imageable    
  	@current_lops = [] unless @type
  	@current_lops = @type.lop_mon_hocs if @type	    
    if @type.is_a?(GiangVien) then 
      @lich = JSON.parse(@type.days)["ngay"]
    end                
  end
end
