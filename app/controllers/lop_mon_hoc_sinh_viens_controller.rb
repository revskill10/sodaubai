class LopMonHocSinhViensController < ApplicationController
  # GET /lop_mon_hoc_sinh_viens
  # GET /lop_mon_hoc_sinh_viens.json
  def index
    @lop_mon_hoc_sinh_viens = LopMonHocSinhVien.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lop_mon_hoc_sinh_viens }
    end
  end

  # GET /lop_mon_hoc_sinh_viens/1
  # GET /lop_mon_hoc_sinh_viens/1.json
  def show
    @lop_mon_hoc_sinh_vien = LopMonHocSinhVien.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lop_mon_hoc_sinh_vien }
    end
  end

  # GET /lop_mon_hoc_sinh_viens/new
  # GET /lop_mon_hoc_sinh_viens/new.json
  def new
    @lop_mon_hoc_sinh_vien = LopMonHocSinhVien.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lop_mon_hoc_sinh_vien }
    end
  end

  # GET /lop_mon_hoc_sinh_viens/1/edit
  def edit
    @lop_mon_hoc_sinh_vien = LopMonHocSinhVien.find(params[:id])
  end

  # POST /lop_mon_hoc_sinh_viens
  # POST /lop_mon_hoc_sinh_viens.json
  def create
    @lop_mon_hoc_sinh_vien = LopMonHocSinhVien.new(params[:lop_mon_hoc_sinh_vien])

    respond_to do |format|
      if @lop_mon_hoc_sinh_vien.save
        format.html { redirect_to @lop_mon_hoc_sinh_vien, notice: 'Lop mon hoc sinh vien was successfully created.' }
        format.json { render json: @lop_mon_hoc_sinh_vien, status: :created, location: @lop_mon_hoc_sinh_vien }
      else
        format.html { render action: "new" }
        format.json { render json: @lop_mon_hoc_sinh_vien.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lop_mon_hoc_sinh_viens/1
  # PUT /lop_mon_hoc_sinh_viens/1.json
  def update
    @lop_mon_hoc_sinh_vien = LopMonHocSinhVien.find(params[:id])

    respond_to do |format|
      if @lop_mon_hoc_sinh_vien.update_attributes(params[:lop_mon_hoc_sinh_vien])
        format.html { redirect_to @lop_mon_hoc_sinh_vien, notice: 'Lop mon hoc sinh vien was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lop_mon_hoc_sinh_vien.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lop_mon_hoc_sinh_viens/1
  # DELETE /lop_mon_hoc_sinh_viens/1.json
  def destroy
    @lop_mon_hoc_sinh_vien = LopMonHocSinhVien.find(params[:id])
    @lop_mon_hoc_sinh_vien.destroy

    respond_to do |format|
      format.html { redirect_to lop_mon_hoc_sinh_viens_url }
      format.json { head :no_content }
    end
  end
end
