class LopMonHocsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :load_lop
  # GET /lop_mon_hocs/1
  # GET /lop_mon_hocs/1.json
  def show
   
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lop_mon_hoc }
    end
  end
  
  
  protected
  def load_lop
    @lop_mon_hoc ||= LopMonHoc.find(params[:id])
  end
end
