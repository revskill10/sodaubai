class LopMonHocsController < ApplicationController
  
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /lop_mon_hocs/1
  # GET /lop_mon_hocs/1.json
  def show
    @lop_mon_hoc = LopMonHoc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lop_mon_hoc }
    end
  end
  
end
