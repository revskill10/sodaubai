class API::V1::LopMonHocSinhVienSinhViensController < ApplicationController
  # GET /sinh_viens
  # GET /sinh_viens.json
  def index
    @lop_mon_hoc_sinh_vien_sinh_viens = LopMonHocSinhVien.all

    respond_to do |format|      
      format.json { render json: @lop_mon_hoc_sinh_vien_sinh_viens }
    end
  end

  # GET /sinh_viens/1
  # GET /sinh_viens/1.json
  def show
    @lop_mon_hoc_sinh_vien = LopMonHocSinhVien.find(params[:id])

    respond_to do |format|      
      format.json { render json: @lop_mon_hoc_sinh_vien }
    end
  end

  # GET /sinh_viens/new
  # GET /sinh_viens/new.json
  def new
    @lop_mon_hoc_sinh_vien = LopMonHocSinhVien.new

    respond_to do |format|      
      format.json { render json: @lop_mon_hoc_sinh_vien }
    end
  end

  # GET /sinh_viens/1/edit
  def edit
    @lop_mon_hoc_sinh_vien = LopMonHocSinhVien.find(params[:id])
  end

  # POST /sinh_viens
  # POST /sinh_viens.json
  def create
    @lop_mon_hoc_sinh_vien = LopMonHocSinhVien.new(params[:lop_mon_hoc_sinh_vien])

    respond_to do |format|
      if @lop_mon_hoc_sinh_vien.save        
        format.json { render json: @lop_mon_hoc_sinh_vien, status: :created, location: @lop_mon_hoc_sinh_vien }
      else        
        format.json { render json: @lop_mon_hoc_sinh_vien.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sinh_viens/1
  # PUT /sinh_viens/1.json
  def update
    @lop_mon_hoc_sinh_vien = LopMonHocSinhVien.find(params[:id])

    respond_to do |format|
      if @lop_mon_hoc_sinh_vien.update_attributes(params[:lop_mon_hoc_sinh_vien])        
        format.json { head :no_content }
      else        
        format.json { render json: @lop_mon_hoc_sinh_vien.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sinh_viens/1
  # DELETE /sinh_viens/1.json
  def destroy
    @lop_mon_hoc_sinh_vien = LopMonHocSinhVien.find(params[:id])
    @lop_mon_hoc_sinh_vien.destroy

    respond_to do |format|      
      format.json { head :no_content }
    end
  end
    
end
