class SinhViensController < ApplicationController
  # GET /sinh_viens
  # GET /sinh_viens.json
  before_filter :authenticate_user!  
  before_filter :load_lop  , :except => :filter
  def index        
    authorize! :read, @lop_mon_hoc
    @sinh_viens = @lop_mon_hoc.sinh_viens
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sinh_viens }
    end
  end
  def filter
    authorize! :manage, LopMonHocSinhVien
    
  end
  def search
    authorize! :search, SinhVien

    
    respond_to do |format|
      format.js
    end
  end
  protected
  def load_lop
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])
  end
    
end
