class DashboardController < ApplicationController

  
  before_filter :load_lops
  def index    

    @current_lich = @lich.select {|l| l["tuan"] == @current_week} if @lich
    if request.headers['X-PJAX']
      render :layout => false
    end
  end
  def show
    
    @current_lich = @lich.select {|l| l["tuan"] == params[:id].to_i} if @lich 
    if request.headers['X-PJAX']      
      render :layout => false
    end
  end
  def calendar
    

    if request.headers['X-PJAX']
      render :layout => false
    end
  end
  
  protected
  def load_lops    
    
    
    @type = current_user.imageable || current_user
    if @type        	
    	@current_lops = @type.lop_mon_hocs
      
      @lich = @type.get_days[:ngay] if @type.get_days
      
      generator = ColorGenerator.new saturation: 0.3, lightness: 0.75
      @color = [] 
      20.times do |i|
        @color << generator.create_hex
      end
      @color_map = {}
      unless @current_lops.empty?
        @current_lops.each_with_index do |l,i|
          @color_map["#{l.ma_lop}-#{l.ma_mon_hoc}"] = @color[i] if l 
        end           
      end
    else
      @current_lops = []
    end
  end

end
