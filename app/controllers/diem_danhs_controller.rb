class DiemDanhsController < ApplicationController
  
  before_filter :load_lop
  # POST /diem_danhs
  # POST /diem_danhs.json
  def create
    @diem_danh2 = DiemDanh.by_lop_sinhvien_ngay(params[:lop_mon_hoc_id],
      params[:ma_sinh_vien], params[:ngay_vang])
    @diem_danh = DiemDanh.new(params[:diem_danh]) if @diem_danh2.empty?
    @current_diemdanh = @diem_danh if @diem_danh 
    @current_diemdanh = @diem_danh2.first unless @diem_danh2.empty?
    if @diem_danh 
      respond_to do |format|
        if @current_diemdanh.save
          format.html { redirect_to @lop_mon_hoc, notice: 'Diem danh was successfully created.' }
          format.json { render json: @current_diemdanh, status: :created, location: @lop_mon_hoc }
          format.js
        else
          format.html { render action: "new" }
          format.json { render json: @current_diemdanh.errors, status: :unprocessable_entity }
          format.js
        end
      end
    elsif @diem_danh2.first
      respond_to do |format|
        if @current_diemdanh.update_attributes(params[:diem_danh])
          format.html { redirect_to @lop_mon_hoc, notice: 'Diem danh was successfully created.' }
          format.json { render json: @current_diemdanh, status: :created, location: @lop_mon_hoc }
          format.js
        else
          format.html { render action: "new" }
          format.json { render json: @current_diemdanh.errors, status: :unprocessable_entity }
          format.js
        end
      end
    end
  end

  

  # DELETE /diem_danhs/1
  # DELETE /diem_danhs/1.json
  def destroy
    @diem_danh = DiemDanh.find(params[:id])
    @diem_danh.destroy

    respond_to do |format|
      format.html { redirect_to diem_danhs_url }
      format.json { head :no_content }
    end
  end

  protected
  def load_lop
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])
  end
end
