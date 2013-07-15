class SinhViensController < ApplicationController
  # GET /sinh_viens
  # GET /sinh_viens.json
  before_filter :authenticate_user!  
  #before_filter :load_lop  
  def index            
    @sinh_viens = SinhVien.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sinh_viens }
    end
  end    
end
