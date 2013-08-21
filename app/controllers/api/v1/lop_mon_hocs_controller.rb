class API::V1::LopMonHocsController < ApplicationController
  # GET /sinh_viens
  # GET /sinh_viens.json
  def index
    @lop_mon_hocs = LopMonHoc.all

    respond_to do |format|      
      format.json { render json: @lop_mon_hocs }
    end
  end

  # GET /sinh_viens/1
  # GET /sinh_viens/1.json
  def show
    @lop_mon_hoc = LopMonHoc.find(params[:id])

    respond_to do |format|      
      format.json { render json: @lop_mon_hoc }
    end
  end

  # GET /sinh_viens/new
  # GET /sinh_viens/new.json
  def new
    @lop_mon_hoc = LopMonHoc.new

    respond_to do |format|      
      format.json { render json: @lop_mon_hoc }
    end
  end

  # GET /sinh_viens/1/edit
  def edit
    @lop_mon_hoc = LopMonHoc.find(params[:id])
  end

  # POST /sinh_viens
  # POST /sinh_viens.json
  def create
    @lop_mon_hoc = LopMonHoc.new(params[:lop_mon_hoc])

    respond_to do |format|
      if @lop_mon_hoc.save        
        format.json { render json: @lop_mon_hoc, status: :created, location: @lop_mon_hoc }
      else        
        format.json { render json: @lop_mon_hoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sinh_viens/1
  # PUT /sinh_viens/1.json
  def update
    @lop_mon_hoc = LopMonHoc.find(params[:id])

    respond_to do |format|
      if @lop_mon_hoc.update_attributes(params[:lop_mon_hoc])        
        format.json { head :no_content }
      else        
        format.json { render json: @lop_mon_hoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sinh_viens/1
  # DELETE /sinh_viens/1.json
  def destroy
    @lop_mon_hoc = LopMonHoc.find(params[:id])
    @lop_mon_hoc.destroy

    respond_to do |format|      
      format.json { head :no_content }
    end
  end
    
end
