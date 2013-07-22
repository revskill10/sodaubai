class LopMonHocsController < ApplicationController
  respond_to :xlsx, :html
  before_filter :authenticate_user!
  before_filter :load_lop
  # GET /lop_mon_hocs/1
  # GET /lop_mon_hocs/1.json
  def show
    @svs = @lop_mon_hoc.get_sinh_viens
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
    @lop_mon_hoc.group = params[:group].to_i

    if @lop_mon_hoc.save! then 
      respond_to do |format|
        format.js
      end
    end
  end
  
  protected
  def load_lop
    @lop_mon_hoc ||= LopMonHoc.find(params[:id])

  end
end
