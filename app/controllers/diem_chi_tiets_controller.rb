class DiemChiTietsController < ApplicationController
  before_filter :load_lop
  def index    
    
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens.order('ten asc')
    @group_diem = JSON.parse(@lop_mon_hoc.group_diem || {}.to_json) 
    respond_to do |format|
      
      format.html do 
        if params[:loai] and params[:loai] == "2" then 
          if request.headers['X-PJAX']
            render :nhom, :layout => false 
          else
            render :nhom
          end
        else
          if request.headers['X-PJAX']
            render :index, :layout => false
          else
            render :index
          end
        end
      end# index.html.erb        
      format.json { head :no_content }
    end
  end

  
  def create
    # @diem_chi_tiet = DiemChiTiet.new(params[:diem_chi_tiet])
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens.order('ten asc')
    @msvs = params[:msv]
    @svs.each do   |sv|      
      sv.diem_thuc_hanh = @msvs[sv.ma_sinh_vien][:thuchanh]
      sv.lan1 = @msvs[sv.ma_sinh_vien][:lan1]
      sv.lan2 = @msvs[sv.ma_sinh_vien][:lan2]
      sv.lan3 = @msvs[sv.ma_sinh_vien][:lan3]
      sv.save! rescue puts "error"
    end

    respond_to do |format|
      if @lop_mon_hoc.save 
        format.js
      else
        render :index
      end
    end
  end

  protected
  def load_lop
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])      
    @malop = @lop_mon_hoc.ma_lop
    @mamonhoc = @lop_mon_hoc.ma_mon_hoc    
    
    @loai = params[:loai]
  end
end
