class BuoihocController < ApplicationController
  before_filter :load_lop, :only => :show
  def show
  	authorize! :read, @lop_mon_hoc
  	@ngay = Date.strptime(params[:id], "%Y-%m-%d")
  	@svs = @lop_mon_hoc.sinh_viens
  end
  
  
  protected
  def load_lop
  	@lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])  	
  end
end
