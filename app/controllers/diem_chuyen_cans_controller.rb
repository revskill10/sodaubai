class DiemChuyenCansController < ApplicationController
  before_filter :load_lop
  # GET /diem_chuyen_cans
  # GET /diem_chuyen_cans.json
  def index
    @svs = @lop_mon_hoc.get_sinh_viens
    @diem_chuyen_cans = @lop_mon_hoc.diem_chuyen_cans

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @diem_chuyen_cans }
    end
  end
  
  # POST /diem_chuyen_cans
  # POST /diem_chuyen_cans.json
  def create
    #todo
  end
 

  

  protected
  def load_lop
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])      
    @malop = @lop_mon_hoc.ma_lop
    @mamonhoc = @lop_mon_hoc.ma_mon_hoc
    
    
  end
end
