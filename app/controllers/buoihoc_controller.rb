require 'date'
require 'json'

class BuoihocController < ApplicationController
  include BuoihocHelper
  before_filter :load_lop
  respond_to :xlsx, :html
  def show
  	authorize! :read, @lop_mon_hoc
  	
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens.order('ten asc')
    @ids = @svs.map{|sv| sv.ma_sinh_vien}
    @lich = @lop_mon_hoc.lich_trinh_giang_days.where(ngay_day: get_ngay(@ngay)).first_or_create!        
    if @lich.voters
      voters = JSON.parse(@lich.voters) 
      @theme = voters[@type.ma_sinh_vien] if @type.is_a?(SinhVien)
    end
    @idv = @lop_mon_hoc.diem_danhs.where(ngay_vang: get_ngay(@ngay)).map { |k| k.ma_sinh_vien}
    @svvang = @svs.select {|k| @idv.include?(k.ma_sinh_vien)}
       
    @svs2 = @svs.each_slice(4)

    
    respond_to do |format|
      if request.headers['X-PJAX']
        if @type.is_a?(SinhVien)
          format.html {render :show_sv, :layout => false}        
        elsif @type.is_a?(GiangVien)
          format.html {render :show, :layout => false}   
        end
      else
        if @type.is_a?(SinhVien)
          format.html {render :show_sv}        
        elsif @type.is_a?(GiangVien)          
          format.html {render :show}        
        end
      end
    end
    
  end
  def update    
    begin
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    @ids = @svs.map{|sv| sv.ma_sinh_vien}    
    



    if params[:msv] then 
      @vang = params[:msv].keys    
          
      @kovang = @svs.map{|sv| sv.ma_sinh_vien}.select{|k| !@vang.include?(k)}
      
      #@kovang = @ids - @msvs 

      @vang.each do |msv|
        sv = @svs.where(ma_sinh_vien: msv).first
        if sv 
          dd = @lop_mon_hoc.diem_danhs.where(ma_sinh_vien: msv, ngay_vang: get_ngay(@ngay)).first_or_create!
          dd.ma_giang_vien = @type.ma_giang_vien
          dd.so_tiet_vang = (@tkb.so_tiet if @tkb)
          dd.phep =  false
          dd.save! rescue "Error save"
        end
      end

      @kovang.each do |msv|
        dd = @lop_mon_hoc.diem_danhs.where(ma_sinh_vien: msv, ngay_vang: get_ngay(@ngay)).first
        if @tkb and dd
          dd.so_tiet_vang = 0
          dd.ma_giang_vien = @type.ma_giang_vien
          dd.phep = false
          dd.save! rescue "Error save"
        end
      end
    end
    
    
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens.order('ten asc')    
    @idv = @lop_mon_hoc.diem_danhs.where(ngay_vang: get_ngay(@ngay)).select{|t| t and t.so_tiet_vang > 0}.map { |k| k.ma_sinh_vien}
    @svvang = @svs.select {|k| @idv.include?(k.ma_sinh_vien)}
    @kovang = @svs.select {|k| !@idv.include?(k.ma_sinh_vien)}
    @lichtrinh = params[:buoihoc]
    @lich = @lop_mon_hoc.lich_trinh_giang_days.where(ngay_day: get_ngay(@ngay)).first_or_create!
    @lich.so_tiet_day = @lichtrinh[:sotiet].to_i if @lichtrinh[:sotiet].to_i <= @tkb.so_tiet and @lichtrinh[:sotiet].to_i > 0
    @lich.noi_dung_day = @lichtrinh[:noidung]
    @lich.phong = @lichtrinh[:phong]
    @lich.so_vang = @vang.count
    @lich.siso = @svs.count
    @lich.sv = {:vang => @vang}.to_json
    @lich.save! rescue "error save lich trinh"
    rescue
      
    end
    respond_to do |format|     
      format.js      
    end
    
  end
  def rate
    @lich = @lop_mon_hoc.lich_trinh_giang_days.where(ngay_day: get_ngay(@ngay)).first
    if @lich             
      voters = (JSON.parse(@lich.voters) if @lich.voters) || {}
      voters[@type.ma_sinh_vien] = params[:theme].to_i
      @lich.voters = voters.to_json
      @lich.rating_score = 0 
      @lich.ratings = 0 
      @lich.ratings = voters.keys.count
      voters.each do |k,v|
        @lich.rating_score += v 
      end
      @lich.save! rescue puts "error"
    end
    respond_to do |format|
      format.js
    end
  end
  def diemdanh            
    begin
      

      params[:msv].each do |k,v|
        dd = @lop_mon_hoc.diem_danhs.where(ma_sinh_vien: k, ngay_vang: get_ngay(@ngay)).first        
        dd = @lop_mon_hoc.diem_danhs.where(ma_sinh_vien: k, ngay_vang: get_ngay(@ngay)).create if !dd and (v[:sotiet].to_i > 0 or !v[:note].blank?)
        if dd 
          dd.ma_giang_vien = @type.ma_giang_vien
          dd.so_tiet_vang = v[:sotiet].to_i          
          dd.phep = v[:phep] ? true : false          
          dd.note = v[:note] unless v[:note].blank?
          dd.save! rescue "Error save"                                              
        end
      end      

    
      @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens.order('ten asc')
      
      @idv = @lop_mon_hoc.diem_danhs.where(ngay_vang: get_ngay(@ngay)).select{|t| t and t.so_tiet_vang > 0}.map { |k| k.ma_sinh_vien}
      @vang = @svs.select {|k| @idv.include?(k.ma_sinh_vien)}
      @kovang = @svs.select {|k| !@idv.include?(k.ma_sinh_vien)}
      respond_to do |format|     
        format.js      
      end
    rescue
      puts "error"
    end
  end
  
  def get_diemdanh
    
   @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens.order('ten asc')

    respond_to do |format|
      if request.headers['X-PJAX']
        if @type.is_a?(GiangVien)
          format.html {render :diemdanh, :layout => false}        
        elsif @type.is_a?(SinhVien)
          format.html {render :diemdanh_sv, :layout => false}        
        end
      else
        if @type.is_a?(GiangVien)
          format.html {render :diemdanh}
          format.xlsx {render xlsx: :diemdanh_doc, filename: "diemdanh_doc"}
        elsif @type.is_a?(SinhVien)
          format.html {render :diemdanh_sv}
        end
                  
      end
    end
  end


  protected
  def to_zdate(str)
    DateTime.strptime(str.gsub("T","-").gsub("Z",""), "%Y-%m-%d-%H:%M").change(:offset => Rational(7,24))
  end
  def load_lop
  	@lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])  	
    @ngay = str_to_ngay(params[:id])
    @malop = @lop_mon_hoc.ma_lop
    @mamonhoc = @lop_mon_hoc.ma_mon_hoc
    @type = current_user.imageable    
    if @type.is_a?(GiangVien) then 
      @lich = @type.get_days[:ngay]
      @tkb = @type.tkb_giang_viens.with_lop(@malop, @mamonhoc).first
      @buoihoc = @lich.select {|l| to_zdate(l["time"][0]) == @ngay}[0]
    elsif @type.is_a?(SinhVien)
      @lich = @type.get_days[:ngay]
      @tkb = @type.get_tkbs.select {|k| k[:ma_lop] == @malop and k[:ma_mon_hoc] == @mamonhoc}.first
      @buoihoc = @lich.select {|l| to_zdate(l["time"][0]) == @ngay}[0]
    end
    #@tuan = @tkb
  end

end
