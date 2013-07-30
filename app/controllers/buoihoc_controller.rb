require 'date'
require 'json'

class BuoihocController < ApplicationController
  include BuoihocHelper
  before_filter :load_lop
  respond_to :xlsx, :html
  def show
  	authorize! :read, @lop_mon_hoc
  	
    @svs = @lop_mon_hoc.get_sinh_viens.sort_by {|h| h.ten}
    @ids = @svs.map{|sv| sv.ma_sinh_vien}
    @lich = @lop_mon_hoc.lich_trinh_giang_days.where(ma_lop: @malop, ma_mon_hoc: @mamonhoc, ngay_day: get_ngay(@ngay)).first
    @dds = DiemDanh.thongtin(@malop,@mamonhoc,@ids, @ngay)
    @vang = @dds.select {|t| t and t.so_tiet_vang > 0}
    @idvang = @vang.map {|t| t.ma_sinh_vien}
    @svvang = @svs.select {|v| @idvang.include?(v.ma_sinh_vien)}
    @svs.each do |sv|
      b2 = @dds.select {|bi| bi.ma_sinh_vien. == sv.ma_sinh_vien}.first
      sv = sv.as_json.merge!(b2.as_json) if b2
    end
    @svs2 = @svs.each_slice(4)

    
    respond_to do |format|
      if request.headers['X-PJAX']
        format.html {render :show, :layout => false}        
      else
        format.html {render :show}        
      end
    end
    
  end
  def update    
    begin
    @svs = @lop_mon_hoc.get_sinh_viens
    @ids = @svs.map{|sv| sv.ma_sinh_vien}    
    



    if params[:msv] then 
      @vang = params[:msv].keys    
          
      @kovang = @svs.map{|sv| sv.ma_sinh_vien}.select{|k| !@vang.include?(k)}
      
      #@kovang = @ids - @msvs 

      @vang.each do |msv|
        dd = DiemDanh.where(ma_sinh_vien: msv, ma_lop: @malop, ma_mon_hoc: @mamonhoc, ngay_vang: get_ngay(@ngay)).first_or_create!
        dd.so_tiet_vang = (@tkb.so_tiet if @tkb)
        dd.phep =  false
        dd.save! rescue "Error save"
      end

      @kovang.each do |msv|
        dd = DiemDanh.where(ma_sinh_vien: msv, ma_lop: @malop, ma_mon_hoc: @mamonhoc, ngay_vang: get_ngay(@ngay)).first
        if @tkb and dd
          dd.so_tiet_vang = 0
          dd.save! rescue "Error save"
        end
      end
    end
    
    
    @dds = DiemDanh.thongtin(@malop,@mamonhoc,@ids, @ngay)
    @vang = @dds.select {|t| t and t.so_tiet_vang > 0}.map {|t| t.ma_sinh_vien}    
    @svvang = @svs.select {|v| @vang.include?(v.ma_sinh_vien)}
    @lichtrinh = params[:buoihoc]
    @lich = @lop_mon_hoc.lich_trinh_giang_days.where(ma_lop: @malop, ma_mon_hoc: @mamonhoc, ngay_day: get_ngay(@ngay)).first_or_create!
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
  def diemdanh            
    begin
      params[:msv].each do |k,v|
        dd = DiemDanh.where(ma_sinh_vien: k, ma_lop: @malop, ma_mon_hoc: @mamonhoc, ngay_vang: @ngay).first        
        dd = DiemDanh.where(ma_sinh_vien: k, ma_lop: @malop, ma_mon_hoc: @mamonhoc, ngay_vang: @ngay).create if !dd and (v[:sotiet].to_i > 0 or !v[:note].blank?)
        if dd 
          dd.so_tiet_vang = v[:sotiet].to_i          
          dd.phep = true if v[:phep] and dd.so_tiet_vang > 0
          dd.phep = false if v[:phep] and dd.so_tiet_vang == 0        
          dd.note = v[:note] unless v[:note].blank?
          dd.save! rescue "Error save"                                              
        end
      end      
    
    
      @svs = @lop_mon_hoc.get_sinh_viens
      @ids = @svs.map{|sv| sv.ma_sinh_vien}    
      @dds = DiemDanh.thongtin(@malop,@mamonhoc,@ids, @ngay)
      @vang = @dds.select {|t| t and t.so_tiet_vang > 0}      
      @kovang = @dds.select {|t| t.nil? or t.so_tiet_vang == 0}
      respond_to do |format|     
        format.js      
      end
    rescue
      puts "error"
    end
  end
  
  def get_diemdanh
    
    @svs = @lop_mon_hoc.get_sinh_viens

    respond_to do |format|
      if request.headers['X-PJAX']
        format.html {render :diemdanh, :layout => false}        
      else
        format.html {render :diemdanh}
        format.xlsx {render xlsx: :diemdanh_doc, filename: "diemdanh_doc"}
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
    end
    #@tuan = @tkb
  end
end
