class LopMonHocSinhViensController < ApplicationController
  # GET /lop_mon_hoc_sinh_viens
  # GET /lop_mon_hoc_sinh_viens.json
  before_filter :load_lop
  def index
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @svs }
    end
  end

  # GET /lop_mon_hoc_sinh_viens/1
  # GET /lop_mon_hoc_sinh_viens/1.json
  def show
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    @sv = @svs.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sv }
    end
  end

  # GET /lop_mon_hoc_sinh_viens/new
  # GET /lop_mon_hoc_sinh_viens/new.json
  def new
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    @sv = LopMonHocSinhVien.new

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
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    @sv = @svs.new(params[:lop_mon_hoc_sinh_vien])

    respond_to do |format|
      if @sv.save
        format.html { redirect_to @sv, notice: 'Lop mon hoc sinh vien was successfully created.' }
        format.json { render json: @sv, status: :created, location: @sv }
      else
        format.html { render action: "new" }
        format.json { render json: @sv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lop_mon_hoc_sinh_viens/1
  # PUT /lop_mon_hoc_sinh_viens/1.json
  def update
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    @sv = @svs.find(params[:id])

    respond_to do |format|
      if @sv.update_attributes(params[:lop_mon_hoc_sinh_vien])
        format.html { redirect_to @sv, notice: 'Lop mon hoc sinh vien was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lop_mon_hoc_sinh_viens/1
  # DELETE /lop_mon_hoc_sinh_viens/1.json
  def destroy
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    @sv = @svs.find(params[:id])
    @sv.destroy

    respond_to do |format|
      #format.html { redirect_to lop_mon_hoc_sinh_viens_url }
      format.json { head :no_content }
    end
  end
  protected
  def load_lop
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])    
  end
end
