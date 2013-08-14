#encoding: utf-8
require 'date'
require 'json'

class BuoihocController < ApplicationController
  include BuoihocHelper
  before_filter :load_lop
  respond_to :xlsx, :html
  def show
  	authorize! :read, @lop_mon_hoc
  	
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    @ids = @svs.map{|sv| sv.ma_sinh_vien}
    @lich = @lop_mon_hoc.lich_trinh_giang_days.where(ngay_day: get_ngay(@ngay)).first_or_create!        
    if @lich.voters
      voters = JSON.parse(@lich.voters) 
      @theme = voters[@type.ma_sinh_vien] if @type.is_a?(SinhVien)
    end
    @idv = @lop_mon_hoc.diem_danhs.where(ngay_vang: get_ngay(@ngay)).select{|t| t and t.so_tiet_vang and t.so_tiet_vang > 0}.map { |k| k.ma_sinh_vien}
    @svvang = @svs.select {|k| @idv.include?(k.ma_sinh_vien)}
    
    
    @svs2 = @svs.each_slice(4)    
    
    respond_to do |format|
      if request.headers['X-PJAX']
        if @type.is_a?(SinhVien)
          format.html {render :show_sv, :layout => false}        
        elsif @type
          format.html {render :show, :layout => false}   
        end
      else
        if @type.is_a?(SinhVien)
          format.html {render :show_sv}        
        elsif @type
          format.html {render :show}        
        end
      end
    end
    
  end
  def update    
    begin    
      authorize! :manage, @lop_mon_hoc
      @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
      @ids = @svs.map {|k| k.ma_sinh_vien}

      if params[:msv]
        params[:msv].each do |k, v|
          dd = @lop_mon_hoc.diem_danhs.where(ma_sinh_vien: k, ngay_vang: get_ngay(@ngay)).first_or_create!     
          dd.ma_lop = @malop
          dd.ma_mon_hoc = @mamonhoc
          dd.ma_giang_vien =  @magiangvien      
          if dd.so_tiet_vang.nil? or (dd.so_tiet_vang and dd.so_tiet_vang == 0)
            dd.so_tiet_vang = @tkb.so_tiet
            dd.phep = false
            dd.save! 
          end
        end
        @kovang = @ids - params[:msv].keys
        dds = @lop_mon_hoc.diem_danhs.where(ma_sinh_vien: @kovang, ngay_vang: get_ngay(@ngay))
        if dds.count > 0
          dds.each do |dd|
            dd.ma_lop = @malop
            dd.ma_mon_hoc = @mamonhoc
            dd.ma_giang_vien =  @magiangvien
            dd.so_tiet_vang = 0
            dd.phep = false
            dd.save!
          end
        end
      else
        dds = @lop_mon_hoc.diem_danhs.where(ma_sinh_vien: @ids, ngay_vang: get_ngay(@ngay))
        if dds.count > 0
          dds.each do |dd|
            dd.ma_lop = @malop
            dd.ma_mon_hoc = @mamonhoc
            dd.ma_giang_vien =  @magiangvien
            dd.so_tiet_vang = 0
            dd.phep = false
            dd.save!
          end
        end
      end
      @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens.order('ten asc')    

      @idv = @lop_mon_hoc.diem_danhs.where(ngay_vang: get_ngay(@ngay)).select{|t| t and t.so_tiet_vang and t.so_tiet_vang > 0}.map { |k| k.ma_sinh_vien}
      @svvang = @svs.select {|k| @idv.include?(k.ma_sinh_vien)}
      @kovang = @svs.select {|k| !@idv.include?(k.ma_sinh_vien)}
      if params[:buoihoc]
        @lichtrinh = params[:buoihoc]      
        @lich = @lop_mon_hoc.lich_trinh_giang_days.where(ngay_day: get_ngay(@ngay)).first_or_create!
        @lich.update_attributes(so_tiet_day: @lichtrinh[:sotiet], noi_dung_day: @lichtrinh[:noidung], phong: @lichtrinh[:phong], so_vang: @svvang.count, siso: @svs.count, sv: {:vang => @vang}.to_json, ma_lop: @malop, ma_mon_hoc: @mamonhoc, ma_giang_vien: @magiangvien) if @lich   
        @lich.save! rescue "error save lich trinh"
      end
    rescue Exception => e
      logger.debug "ERROR #{e}"
    end
  
    respond_to do |format|     
      format.js      
    end
    
  end
  def rate
    authorize! :rate, @lop_mon_hoc
    @lich = @lop_mon_hoc.lich_trinh_giang_days.where(ngay_day: get_ngay(@ngay)).first
    if @lich             
      if params[:theme].to_i >= 0 and params[:theme].to_i <= 5 then 
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
      else
        @error = "Đã có lỗi xảy ra"
      end
    end
    respond_to do |format|
      format.js
    end
  end
  def diemdanh            
    begin      
      authorize! :manage, @lop_mon_hoc
      params[:msv].each do |k,v|
        dd = @lop_mon_hoc.diem_danhs.where(ma_sinh_vien: k, ngay_vang: get_ngay(@ngay)).first        
        dd = @lop_mon_hoc.diem_danhs.where(ma_sinh_vien: k, ngay_vang: get_ngay(@ngay)).create if !dd and (v[:sotiet].to_i > 0 or !v[:note].blank?)
        if dd 
          #dd.ma_giang_vien = @type.try(:ma_giang_vien) || @type.try(:code)
          st = v[:sotiet].to_i 
          if st and st >=0 and @tkb and st <= @tkb.so_tiet  
            dd.ma_lop = @malop
            dd.ma_mon_hoc = @mamonhoc
            dd.ma_giang_vien =  @magiangvien
            dd.so_tiet_vang = st
            dd.phep = (v[:phep] and st > 0) ? true : false          
            dd.note = v[:note] unless v[:note].blank?
            dd.save! rescue "Error save"                                              
          else
            @error = true
            @msg = "Số tiết vắng không hợp lệ"
            break
          end
        end
      end      

    
      @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens.order
      
      @idv = @lop_mon_hoc.diem_danhs.where(ngay_vang: get_ngay(@ngay)).select{|t| t and t.so_tiet_vang and t.so_tiet_vang > 0}.map { |k| k.ma_sinh_vien}
      @vang = @svs.select {|k| @idv.include?(k.ma_sinh_vien)}
      @kovang = @svs.select {|k| !@idv.include?(k.ma_sinh_vien)}
      respond_to do |format|     
        format.js      
      end
    rescue Exception => e
      puts e
    end
  end
  
  def get_diemdanh
    
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    @lich = @lop_mon_hoc.lich_trinh_giang_days.where(ngay_day: get_ngay(@ngay)).first_or_create!        
    @idv = @lop_mon_hoc.diem_danhs.where(ngay_vang: get_ngay(@ngay)).select{|t| t and t.so_tiet_vang and t.so_tiet_vang > 0}.map { |k| k.ma_sinh_vien}
    @svvang = @svs.select {|k| @idv.include?(k.ma_sinh_vien)}
    respond_to do |format|
      if request.headers['X-PJAX']
        if @type.is_a?(GiangVien)
          format.html {render :diemdanh, :layout => false}        
        elsif @type.is_a?(SinhVien)
          format.html {render :diemdanh_sv, :layout => false}        
        elsif @type
          format.html {render :diemdanh, :layout => false}
        end
      else
        if @type.is_a?(GiangVien)
          format.html {render :diemdanh}
          format.xlsx {render xlsx: :diemdanh_doc, filename: "diemdanh_doc"}
        elsif @type.is_a?(SinhVien)
          format.html {render :diemdanh_sv}
        elsif @type
          format.html {render :diemdanh}
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
    @magiangvien = @lop_mon_hoc.ma_giang_vien
    @role = current_user.role
    @type = current_user.imageable
    if @type.is_a?(GiangVien) then 
      @lich = @type.get_days[:ngay]
      @tkb = @type.get_tkbs.select {|k| k[:ma_lop] == @malop and k[:ma_mon_hoc] == @mamonhoc}.first
      @buoihoc = @lich.select {|l| to_zdate(l["time"][0]) == @ngay}[0]
    elsif @type.is_a?(SinhVien)
      @lich = @type.get_days[:ngay]
      @tkb = @type.get_tkbs.select {|k| k[:ma_lop] == @malop and k[:ma_mon_hoc] == @mamonhoc}.first
      @buoihoc = @lich.select {|l| to_zdate(l["time"][0]) == @ngay}[0]
    elsif @role == 'trogiang'  
      @type = current_user    
      @lich = @type.get_days[:ngay] if @type.get_days
      @tkb = @type.get_tkbs.select {|k| k[:ma_lop] == @malop and k[:ma_mon_hoc] == @mamonhoc}.first
      @buoihoc = @lich.select {|l| to_zdate(l["time"][0]) == @ngay}[0] if @lich
    end    
    #end
    #@tuan = @tkb
  end

end
