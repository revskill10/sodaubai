class LopMonHocsController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /lop_mon_hocs/1
  # GET /lop_mon_hocs/1.json
  def show
    @lop_mon_hoc = LopMonHoc.find(params[:id])
    authorize! :read, @lop_mon_hoc
    @lichs = @lop_mon_hoc.tkb_giang_viens.map {|l| {:thu => l.thu.to_s, :lich => l.schedule.all_occurrences} }
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lop_mon_hoc }
    end
  end
  
end
