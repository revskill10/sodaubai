class DiemChuyenCansController < ApplicationController
  before_filter :load_lop
  # GET /diem_chuyen_cans
  # GET /diem_chuyen_cans.json
  def index
    @svs = @lop_mon_hoc.get_sinh_viens
    @msvs = @svs.map {|k| k.ma_sinh_vien}
    @diem_chuyen_cans = DiemChuyenCan.where(ma_lop: @malop, ma_mon_hoc: @mamonhoc, ma_sinh_vien: @msvs)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @diem_chuyen_cans }
    end
  end
  
  # POST /diem_chuyen_cans
  # POST /diem_chuyen_cans.json
  def create
    #todo
    @msvs = params[:msv].select {|k,v| v.strip != ""}
    @msvs.each do |k,v|
      dcc = @lop_mon_hoc.diem_chuyen_cans.where(ma_sinh_vien: k).first_or_create!
      dcc.diem = v.strip.to_i
      dcc.save! rescue "error save dcc"
    end

    respond_to do |format|
      format.js
    end
  end
 

  

  protected
  def load_lop
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])      
    @malop = @lop_mon_hoc.ma_lop
    @mamonhoc = @lop_mon_hoc.ma_mon_hoc
    
    
  end
end
