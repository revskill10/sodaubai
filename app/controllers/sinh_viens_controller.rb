class SinhViensController < ApplicationController
  # GET /sinh_viens
  # GET /sinh_viens.json
  before_filter :authenticate_user!  
  before_filter :load_lop  , :except => :show
  def index        
    authorize! :read, SinhVien
    @sinh_vien = SinhVien.where(ma_sinh_vien: params[:id]).first
    @lops = @sinh_vien.lop_mon_hocs
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sinh_viens }
    end
  end
  
  def show    
    @sinh_vien = SinhVien.where(ma_sinh_vien: params[:id]).first
    raise ActiveRecord::RecordNotFound unless @sinh_vien    
    @lichs = @sinh_vien.lich_trinh_giang_days.sort_by {|l| [l.ngay_day, l.tuan]}
    @lichvangs = @sinh_vien.lich_vangs.map(&:id)

    respond_to do |format|
      format.html
    end
  end
  
  protected
  def load_lop
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])
  end
    
end
