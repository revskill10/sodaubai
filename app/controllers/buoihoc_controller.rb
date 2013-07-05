require 'date'
require 'json'

class BuoihocController < ApplicationController
  before_filter :load_lop
  def show
  	authorize! :read, @lop_mon_hoc
  	
    @svs = @lop_mon_hoc.get_sinh_viens.sort_by {|h| h[:ten]}
    @ids = @svs.map{|sv| sv[:ma_sinh_vien]}
    
    @dds = DiemDanh.thongtin(@malop,@mamonhoc,@ids, @ngay)
    @svs.each do |sv|
      b2 = @dds.select {|bi| bi[:ma_sinh_vien] == sv[:ma_sinh_vien]}.first
      sv.merge!(b2.as_json) if b2
    end
    @svs2 = @svs.each_slice(4)

    if request.headers['X-PJAX']
      render :layout => false
    end
  end
  def update    
    @svs = @lop_mon_hoc.get_sinh_viens.sort_by {|h| h[:ten]}
    @ids = @svs.map{|sv| sv[:ma_sinh_vien]}
    @dds = DiemDanh.thongtin(@malop,@mamonhoc,@ids, @ngay)
    @svs.each do |sv|
      b2 = @dds.select {|bi| bi[:ma_sinh_vien] == sv.ma_sinh_vien}.first
      if b2 
        b3 = b2.as_json.symbolize_keys       
        sv.merge!(b3)
      end
    end
    @svs2 = @svs.each_slice(4)

    #puts dds.inspect
    if request.headers['X-PJAX']
      render :show, :layout => false
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

    if request.headers['X-PJAX']
      render :diemdanh, :layout => false
    else
      render :diemdanh
    end
  end

  def diemdanh
    puts params.inspect
    msvs = []
    params.each do |k,v|
      if k.to_s.include?("msv") then 
        msvs << {:msv => k[4..-1], :vang => v.to_i}
      end
    end
    if msvs.length > 0 then 
      msvs.each do |ms|
        dds = DiemDanh.thongtin(@malop,@mamonhoc,ms[:msv], @ngay)
        if dds.empty?   
          if ms[:vang] > 0  
          DiemDanh.create(ma_sinh_vien: ms[:msv], ma_lop: @malop, ma_mon_hoc: @mamonhoc, ngay_vang: @ngay, so_tiet_vang: ms[:vang])
          end
        else

          dds.first.update_attributes(so_tiet_vang: ms[:vang])
        end
      end
    end
    @svs = @lop_mon_hoc.get_sinh_viens
    if request.headers['X-PJAX']
      render :diemdanh, :layout => false
    end
  end

  protected
  def load_lop
  	@lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])  	
    @ngay = DateTime.strptime(params[:id], "%Y-%m-%d-%H-%M").change(:offset => Rational(7,24))
    @malop = @lop_mon_hoc.ma_lop
    @mamonhoc = @lop_mon_hoc.ma_mon_hoc
    
    
  end
end
