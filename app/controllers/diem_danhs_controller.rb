class DiemDanhsController < ApplicationController
  # GET /diem_danhs
  # GET /diem_danhs.json
  def index
    @diem_danhs = DiemDanh.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @diem_danhs }
    end
  end

  # GET /diem_danhs/1
  # GET /diem_danhs/1.json
  def show
    @diem_danh = DiemDanh.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @diem_danh }
    end
  end

  # GET /diem_danhs/new
  # GET /diem_danhs/new.json
  def new
    @diem_danh = DiemDanh.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @diem_danh }
    end
  end

  # GET /diem_danhs/1/edit
  def edit
    @diem_danh = DiemDanh.find(params[:id])
  end

  # POST /diem_danhs
  # POST /diem_danhs.json
  def create
    @diem_danh = DiemDanh.new(params[:diem_danh])

    respond_to do |format|
      if @diem_danh.save
        format.html { redirect_to @diem_danh, notice: 'Diem danh was successfully created.' }
        format.json { render json: @diem_danh, status: :created, location: @diem_danh }
      else
        format.html { render action: "new" }
        format.json { render json: @diem_danh.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /diem_danhs/1
  # PUT /diem_danhs/1.json
  def update
    @diem_danh = DiemDanh.find(params[:id])

    respond_to do |format|
      if @diem_danh.update_attributes(params[:diem_danh])
        format.html { redirect_to @diem_danh, notice: 'Diem danh was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @diem_danh.errors, status: :unprocessable_entity }
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
end
