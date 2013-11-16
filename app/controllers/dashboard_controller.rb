#encoding: utf-8
class DashboardController < ApplicationController

  
  before_filter :load_lops, :except => [:search]
  def index    

    @current_lich = @lich.select {|l| l["tuan"] == @current_week}.uniq if @lich
    @current_lich2 = @lich2.select {|l| l["tuan"] == @current_week}.uniq if @lich2
    
    @lichbus = @lichbosungs.select {|l| l.loai == 2 and l.status == 3 and l.tuan == @current_week} if @lichbosungs    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Dashboard", :action => "index", :label => "#{current_user.username}", :value => "1"}.to_json
  end

  def activity
    if current_user.imageable.is_a?(SinhVien)      
      @activities = PublicActivity::Activity.where(recipient_id: current_user.imageable.id).order('updated_at desc').page(params[:page]).per_page(50)
    elsif current_user.imageable and current_user.imageable.is_a?(GiangVien)
      @activities = PublicActivity::Activity.where(owner_id: current_user.id).order('updated_at desc').page(params[:page]).per_page(50)
    elsif current_user.is_admin?
      @activities = PublicActivity::Activity.order('updated_at desc').page(params[:page]).per_page(50)
    end    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Dashboard", :action => "activity", :label => "#{current_user.username}", :value => "1"}.to_json
  end

  def show
    @current_lich = @lich.select {|l| l["tuan"] == params[:id].to_i}.uniq if @lich 
    @current_lich2 = @lich2.select {|l| l["tuan"] == @current_week}.uniq if @lich2
    QC.enqueue "GoogleAnalytic.perform", {:category => "Dashboard", :action => "show", :label => "#{current_user.username}", :value => "1"}.to_json
  end
  def calendar
    @lichbus = []
    @lichdkbs = []
    @lichbus += @lichbosungs.select {|l| l.loai == 2 and l.status == 3} if @lichbosungs
    @lichdkbs += @lichbosungs.select {|l| l.loai == 5 and l.status == 3} if @lichbosungs
    @lichbus += @lichbosungs2.select {|l| l.loai == 2 and l.status == 3} if @lichbosungs2
    @lichdkbs += @lichbosungs2.select {|l| l.loai == 5 and l.status == 3} if @lichbosungs2

    QC.enqueue "GoogleAnalytic.perform", {:category => "Dashboard", :action => "calendar", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|
      if @type.is_a?(GiangVien) or current_user.role == 'trogiang'
        format.html { render :calendar }
      else
        format.html { render :calendar_sv }
      end
    end
  end
  def post_calendar
    if @type.is_a?(GiangVien) or current_user.role == 'trogiang'
      lops = params[:lich]
      unless lops.empty?
        lops.each do |k,v|
          lop = LopMonHoc.find(k)
          if lop 
            authorize! :manage, lop
            lop.ngay_thua = {:ngay => v}.to_json
            lop.save!
          end
        end
      end
    end
  end
  def search
    @type = params[:type]
    @keyword = params[:search]
    if params[:type] == '1'
      @search = Sunspot.search(SinhVien) do 
        fulltext params[:search]
        SinhVien::FACETS.each do |f|
          facet(f)
        end        
        with(:lop_hc, params[:lop_hc]) if params[:lop_hc].present?
        with(:ten, params[:ten]) if params[:ten].present?
        with(:ten_nganh, params[:ten_nganh]) if params[:ten_nganh].present?
        with(:ma_khoa_hoc, params[:ma_khoa_hoc]) if params[:ma_khoa_hoc].present?
        paginate(:page => params[:page] || 1, :per_page => 50)
      end
      @results = @search.results
    elsif params[:type] == '2'
      @search = Sunspot.search(LopMonHoc) do 
        fulltext params[:search]
        
        LopMonHoc::FACETS.each do |f|
          facet(f)
        end        
        with(:ten_mon_hoc, params[:ten_mon_hoc]) if params[:ten_mon_hoc].present?
        with(:ten_giang_vien, params[:ten_giang_vien]) if params[:ten_giang_vien].present?
        with(:phong_hoc, params[:phong_hoc]) if params[:phong_hoc].present?
        paginate(:page => params[:page] || 1, :per_page => 50)
      end
      @results = @search.results
    end    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Dashboard", :action => "search", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|      
      format.html      
    end
  end
  protected
  def to_zdate(str)
    DateTime.strptime(str.gsub("T","-").gsub("Z",""), "%Y-%m-%d-%H:%M").change(:offset => Rational(7,24))
  end
  def load_lops    
    
    
    @type = current_user.imageable
    if @type        	
    	@current_lops = @type.lop_mon_hocs
      @lop_xongs = @current_lops.select {|t| t.da_day_xong == true}.map {|k| k and k.id}
      @lich = @type.get_days[:ngay].uniq if @type.get_days
      @lichthua = current_user.get_thua[:ngay].uniq if current_user.get_thua and @type.is_a?(GiangVien)
      @lichbosungs = @type.lich_trinh_giang_days.select {|l| [1,2,3,4,5].include?(l.loai)}

      generator = ColorGenerator.new saturation: 0.3, lightness: 0.75
      @color = [] 
      20.times do |i|
        @color << generator.create_hex
      end
      @color_map = {}
      @info = {}
      unless @current_lops.empty?
        @current_lops.each_with_index do |l,i|
          @color_map["#{l.ma_lop}-#{l.ma_mon_hoc}"] = @color[i] if l 
        end           
      end
      unless @lichbosungs.empty?
        @lichbosungs.each_with_index do |l,i|
          @color_map["#{l.ngay_day.localtime.strftime('%Y-%m-%d-%H:%M')}"] = "A00000"
          @info["#{l.ngay_day.localtime.strftime('%Y-%m-%d-%H:%M')}"] = l.info
        end
      end
    else
      @current_lops = []
    end


    
    @current_lops2 = current_user.lop_mon_hocs
    @lop_xongs2 = @current_lops2.select {|t| t.da_day_xong == true}.map {|k| k and k.id}
    @lichbosungs2 = current_user.lich_trinh_giang_days.select {|l| [1,2,3,4,5].include?(l.loai)}
    @lich2 = current_user.get_days[:ngay].uniq if current_user.get_days
    @lichthua2 = current_user.get_thua[:ngay].uniq if current_user.get_thua
    generator = ColorGenerator.new saturation: 0.2, lightness: 0.8
    @color2 = [] 
    20.times do |i|
      @color2 << generator.create_hex
    end
    @color_map2 = {}
    @info2 = {}
    unless @current_lops2.empty?
      @current_lops2.each_with_index do |l,i|
        @color_map2["#{l.ma_lop}-#{l.ma_mon_hoc}"] = @color2[i] if l 
      end           
    end
    unless @lichbosungs2.empty?
      @lichbosungs2.each_with_index do |l,i|
        @color_map2["#{l.ngay_day.localtime.strftime('%Y-%m-%d-%H:%M')}"] = "A00000"
        @info2["#{l.ngay_day.localtime.strftime('%Y-%m-%d-%H:%M')}"] = l.info
      end
    end
  end

end
