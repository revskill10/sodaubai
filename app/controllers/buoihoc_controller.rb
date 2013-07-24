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
    
    @dds = DiemDanh.thongtin(@malop,@mamonhoc,@ids, @ngay)
    @svs.each do |sv|
      b2 = @dds.select {|bi| bi.ma_sinh_vien. == sv.ma_sinh_vien}.first
      sv = sv.as_json.merge!(b2.as_json) if b2
    end
    @svs2 = @svs.each_slice(4)

    
    if request.headers['X-PJAX']
        render :layout => false
    end
    
  end
  def update    
    @svs = @lop_mon_hoc.get_sinh_viens
    @vang = params["msv"].keys    
    @kovang = @svs.map{|sv| sv.ma_sinh_vien}.select{|k| !@vang.include?(k)}
    begin
    #@kovang = @ids - @msvs 

    @vang.each do |msv|
      dd = DiemDanh.where(ma_sinh_vien: msv, ma_lop: @malop, ma_mon_hoc: @mamonhoc, ngay_vang: get_ngay(@ngay)).first_or_create!
      dd.so_tiet_vang = @tkb.so_tiet if @tkb
      dd.save! rescue "Error save"
    end

    @kovang.each do |msv|
      dd = DiemDanh.where(ma_sinh_vien: msv, ma_lop: @malop, ma_mon_hoc: @mamonhoc, ngay_vang: get_ngay(@ngay)).first
      if @tkb and dd
        dd.so_tiet_vang = 0
        dd.save! rescue "Error save"
      end
    end
    puts  params[:msv].keys.inspect
    puts @ids.inspect
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
        dd = DiemDanh.where(ma_sinh_vien: k, ma_lop: @malop, ma_mon_hoc: @mamonhoc, ngay_vang: @ngay).create if !dd and (v[:status] or v[:sotiet].to_i > 0 or !v[:note].blank?)
        
        if v[:status] 
          dd.so_tiet_vang = @tkb.so_tiet if v[:sotiet].to_i == 0
          dd.so_tiet_vang = v[:sotiet].to_i if v[:sotiet].to_i > 0 and v[:sotiet].to_i <= @tkb.so_tiet
        else            
          dd.so_tiet_vang = v[:sotiet].to_i if v[:sotiet].to_i > 0 and v[:sotiet].to_i <= @tkb.so_tiet
        end
        dd.phep = true if v[:phep] and dd.so_tiet_vang > 0
        dd.phep = false if v[:phep] and dd.so_tiet_vang == 0        
        dd.note = v[:note] unless v[:note].blank?
        dd.save! rescue "Error save"                                              
      end
    rescue

    end
    
    @svs = @lop_mon_hoc.get_sinh_viens
    respond_to do |format|     
      format.js      
    end
  end
  # for update/create
  def syllabus
    puts params.inspect

    @lich = LichTrinhGiangDay.where(ma_lop: @lop_mon_hoc.ma_lop, ma_mon_hoc: @lop_mon_hoc.ma_mon_hoc, ngay_day: Time.zone.parse(@ngay.to_s)).first
    @lich.noi_dung_day = params[:noidung]
    @lich.nhan_xet_buoi_hoc = params[:nhanxet]
    @lich.phong = params[:phong]
    @lich.so_tiet_day = params[:so_tiet_day]
    if request.headers['X-PJAX']
      if @lich.save then 
        flash[:success] = "Update OK"
        render :lichtrinh, :layout => false
      else
        flash[:error] = "Error update"
        render :lichtrinh_edit, :layout => false
      end
    end
  end
  # for get
  def lichtrinh
    #@lich_trinh_giang_day = LichTrinhGiangDay.new
    @lich = LichTrinhGiangDay.where(ma_lop: @lop_mon_hoc.ma_lop, ma_mon_hoc: @lop_mon_hoc.ma_mon_hoc, ngay_day: Time.zone.parse(@ngay.to_s)).first_or_create!
    
    if request.headers['X-PJAX']
      if @lich.save then 
        render :lichtrinh, :layout => false
      else
        render :error, :layout => false
      end      
    end
  end
  def lichtrinh_edit
    @lich = LichTrinhGiangDay.where(ma_lop: @lop_mon_hoc.ma_lop, ma_mon_hoc: @lop_mon_hoc.ma_mon_hoc, ngay_day: Time.zone.parse(@ngay.to_s)).first
    if request.headers['X-PJAX']
      if @lich.present? then                 
        render :lichtrinh_edit, :layout => false
      else
        render :error, :layout => false
      end      
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
  def load_lop
  	@lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])  	
    @ngay = str_to_ngay(params[:id])
    @malop = @lop_mon_hoc.ma_lop
    @mamonhoc = @lop_mon_hoc.ma_mon_hoc
    @type = current_user.imageable    
    if @type.is_a?(GiangVien) then 
      @tkb = @type.tkb_giang_viens.with_lop(@malop, @mamonhoc).first
    end
    
  end
end
