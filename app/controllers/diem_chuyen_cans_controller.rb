class DiemChuyenCansController < ApplicationController
  before_filter :load_lop
  # GET /diem_chuyen_cans
  # GET /diem_chuyen_cans.json
  def index
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens.order('ten asc')
    
    
    
    respond_to do |format|
      if request.headers['X-PJAX']
        format.html {render :index, :layout => false}             
      else
        format.html {render :index}        
      end
    end   
  end
  
  # POST /diem_chuyen_cans
  # POST /diem_chuyen_cans.json
  def create
    #todo
    @msvs = params[:msv]
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens.order('ten asc')
    @svs.each do |sv|
      if @msvs[sv.ma_sinh_vien]
        sv.diem_chuyen_can = @msvs[sv.ma_sinh_vien]
        sv.save! rescue puts "error"
      end
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
