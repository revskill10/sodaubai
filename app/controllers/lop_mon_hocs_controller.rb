class LopMonHocsController < ApplicationController
  include DashboardHelper
  respond_to :xlsx, :html
  before_filter :authenticate_user!
  before_filter :load_lop
  # GET /lop_mon_hocs/1
  # GET /lop_mon_hocs/1.json
  def show
    authorize! :read, @lop_mon_hoc
    @svs = @lop_mon_hoc.get_sinh_viens
    @diem_chuyen_cans = @lop_mon_hoc.diem_chuyen_cans
    @dccs = {}
    @dccs2 = {}
    @diem_chuyen_cans.each do |dcc|
     @dccs[dcc.ma_sinh_vien] = dcc.tong_so_tiet_vang || 0
     @dccs2[dcc.ma_sinh_vien] = dcc.so_tiet || 1
    end
    respond_to do |format|
      if request.headers['X-PJAX']
        format.html {render :layout => false}        
      else
        format.html {render :show}
        format.xlsx {render xlsx: :dslop, filename: "dslop_doc"}
      end
    end
  end
  def update
    sn = params[:so_nhom].blank? ? 1 : params[:so_nhom]
    @lop_mon_hoc.update_attributes(group: sn)

    if @lop_mon_hoc.save! then 
      respond_to do |format|
        format.js
      end
    end
  end
  def calendar
    @lich = @lop_mon_hoc.get_days
    respond_to do |format|
      if request.headers['X-PJAX']
        format.html {render :calendar, :layout => false}        
      else        
        format.html {render :calendar}        
      end

    end
  end
 
  protected
  def load_lop
    @lop_mon_hoc ||= LopMonHoc.find(params[:id])

  end
end
