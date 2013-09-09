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
    authorize! :read, SinhVien
    @sinh_vien = SinhVien.where(ma_sinh_vien: params[:id]).first
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])

    if @sinh_vien
      @dd = @sinh_vien.diem_danhs.includes(:lich_trinh_giang_day => :lop_mon_hoc).all

      @grid = PivotTable::Grid.new do |g|
        g.source_data = @dd
        g.column_name = :tuan
        g.row_name = :lop_mon_hoc
      end
      @grid.build
    end

    respond_to do |format|

      format.html
    end
  end
  
  protected
  def load_lop
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])
  end
    
end
