class DiemChuyenCansController < ApplicationController
  # GET /diem_chuyen_cans
  # GET /diem_chuyen_cans.json
  def index
    @diem_chuyen_cans = DiemChuyenCan.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @diem_chuyen_cans }
    end
  end

  # GET /diem_chuyen_cans/1
  # GET /diem_chuyen_cans/1.json
  def show
    @diem_chuyen_can = DiemChuyenCan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @diem_chuyen_can }
    end
  end

  # GET /diem_chuyen_cans/new
  # GET /diem_chuyen_cans/new.json
  def new
    @diem_chuyen_can = DiemChuyenCan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @diem_chuyen_can }
    end
  end

  # GET /diem_chuyen_cans/1/edit
  def edit
    @diem_chuyen_can = DiemChuyenCan.find(params[:id])
  end

  # POST /diem_chuyen_cans
  # POST /diem_chuyen_cans.json
  def create
    @diem_chuyen_can = DiemChuyenCan.new(params[:diem_chuyen_can])

    respond_to do |format|
      if @diem_chuyen_can.save
        format.html { redirect_to @diem_chuyen_can, notice: 'Diem chuyen can was successfully created.' }
        format.json { render json: @diem_chuyen_can, status: :created, location: @diem_chuyen_can }
      else
        format.html { render action: "new" }
        format.json { render json: @diem_chuyen_can.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /diem_chuyen_cans/1
  # PUT /diem_chuyen_cans/1.json
  def update
    @diem_chuyen_can = DiemChuyenCan.find(params[:id])

    respond_to do |format|
      if @diem_chuyen_can.update_attributes(params[:diem_chuyen_can])
        format.html { redirect_to @diem_chuyen_can, notice: 'Diem chuyen can was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @diem_chuyen_can.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diem_chuyen_cans/1
  # DELETE /diem_chuyen_cans/1.json
  def destroy
    @diem_chuyen_can = DiemChuyenCan.find(params[:id])
    @diem_chuyen_can.destroy

    respond_to do |format|
      format.html { redirect_to diem_chuyen_cans_url }
      format.json { head :no_content }
    end
  end
end
