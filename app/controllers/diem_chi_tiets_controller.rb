class DiemChiTietsController < ApplicationController
  # GET /diem_chi_tiets
  # GET /diem_chi_tiets.json
  def index
    @diem_chi_tiets = DiemChiTiet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @diem_chi_tiets }
    end
  end

  # GET /diem_chi_tiets/1
  # GET /diem_chi_tiets/1.json
  def show
    @diem_chi_tiet = DiemChiTiet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @diem_chi_tiet }
    end
  end

  # GET /diem_chi_tiets/new
  # GET /diem_chi_tiets/new.json
  def new
    @diem_chi_tiet = DiemChiTiet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @diem_chi_tiet }
    end
  end

  # GET /diem_chi_tiets/1/edit
  def edit
    @diem_chi_tiet = DiemChiTiet.find(params[:id])
  end

  # POST /diem_chi_tiets
  # POST /diem_chi_tiets.json
  def create
    @diem_chi_tiet = DiemChiTiet.new(params[:diem_chi_tiet])

    respond_to do |format|
      if @diem_chi_tiet.save
        format.html { redirect_to @diem_chi_tiet, notice: 'Diem chi tiet was successfully created.' }
        format.json { render json: @diem_chi_tiet, status: :created, location: @diem_chi_tiet }
      else
        format.html { render action: "new" }
        format.json { render json: @diem_chi_tiet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /diem_chi_tiets/1
  # PUT /diem_chi_tiets/1.json
  def update
    @diem_chi_tiet = DiemChiTiet.find(params[:id])

    respond_to do |format|
      if @diem_chi_tiet.update_attributes(params[:diem_chi_tiet])
        format.html { redirect_to @diem_chi_tiet, notice: 'Diem chi tiet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @diem_chi_tiet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diem_chi_tiets/1
  # DELETE /diem_chi_tiets/1.json
  def destroy
    @diem_chi_tiet = DiemChiTiet.find(params[:id])
    @diem_chi_tiet.destroy

    respond_to do |format|
      format.html { redirect_to diem_chi_tiets_url }
      format.json { head :no_content }
    end
  end
end
