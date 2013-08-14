class DashboardController < ApplicationController

  
  before_filter :load_lops
  def index    

    @current_lich = @lich.select {|l| l["tuan"] == @current_week}.uniq if @lich
    @current_lich2 = @lich2.select {|l| l["tuan"] == @current_week}.uniq if @lich2
    if request.headers['X-PJAX']
      render :layout => false
    end
  end
  def show
    
    @current_lich = @lich.select {|l| l["tuan"] == params[:id].to_i}.uniq if @lich 
    @current_lich2 = @lich2.select {|l| l["tuan"] == @current_week}.uniq if @lich2
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
    
    
    @type = current_user.imageable
    if @type        	
    	@current_lops = @type.lop_mon_hocs
      
      @lich = @type.get_days[:ngay].uniq if @type.get_days
      
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


    
    @current_lops2 = current_user.lop_mon_hocs
    
    @lich2 = current_user.get_days[:ngay] if current_user.get_days
    
    generator = ColorGenerator.new saturation: 0.2, lightness: 0.8
    @color2 = [] 
    20.times do |i|
      @color2 << generator.create_hex
    end
    @color_map2 = {}
    unless @current_lops2.empty?
      @current_lops2.each_with_index do |l,i|
        @color_map2["#{l.ma_lop}-#{l.ma_mon_hoc}"] = @color2[i] if l 
      end           
    end
    
  end

end
