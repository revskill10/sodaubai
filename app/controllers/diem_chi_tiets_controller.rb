class DiemChiTietsController < ApplicationController
  before_filter :load_lop
  def index    
    
    @svs = @lop_mon_hoc.get_sinh_viens
    @group_diem = JSON.parse(@lop_mon_hoc.group_diem)
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
    @svs = @lop_mon_hoc.get_sinh_viens
    if params[:loai] and params[:loai] == "2" then 
      @lop_mon_hoc.group_diem = params[:group].to_json
      params[:group].each do |k,v|
        sn = @svs.select{|s| s.group_id == k.to_i}
        sn.each do |s|
          dc = @dct.where(ma_lop: @malop, ma_mon_hoc: @mamonhoc,ma_sinh_vien: s.ma_sinh_vien, loai_diem: "2").first_or_create!
          dc.diem = v.to_i
          dc.save rescue "Save grade error"
        end
      end
    else

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
    @dct = @lop_mon_hoc.diem_chi_tiets
    @loai = params[:loai]
  end
end
