#encoding : UTF-8
class DiemChuyenCansController < ApplicationController
  before_filter :load_lop
  # GET /diem_chuyen_cans
  # GET /diem_chuyen_cans.json
  def index
    authorize! :read, @lop_mon_hoc
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens.order('ten asc')
    
    
    
    respond_to do |format|
      if can? :manage, @lop_mon_hoc
        format.html {render :index}             
      elsif can? :read, @lop_mon_hoc
        format.html {render :index_sv}        
      end
    end   
  end
  
  # POST /diem_chuyen_cans
  # POST /diem_chuyen_cans.json
  def create
    #todo
    authorize! :manage, @lop_mon_hoc
    @msvs = params[:msv]
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens.order('ten asc')
    @svs.each do |sv|
      if @msvs[sv.ma_sinh_vien] and @msvs[sv.ma_sinh_vien] >= 0 and @msvs[sv.ma_sinh_vien] <= 10
        sv.diem_chuyen_can = @msvs[sv.ma_sinh_vien]
        sv.diem_qua_trinh = sv.diemqt
        if sv.diem_chuyen_can == 0 
          sv.note = "Mất tư cách"
        else
          sv.note = nil
        end
        sv.save! rescue puts "error"
      else
        @error = "Đã có lỗi xảy ra, vui lòng kiểm tra lại dữ liệu"
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
