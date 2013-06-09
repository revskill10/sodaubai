class DangKyDayBusController < ApplicationController
  # GET /dang_ky_day_bus
  # GET /dang_ky_day_bus.json
  def index
    @dang_ky_day_bus = DangKyDayBu.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dang_ky_day_bus }
    end
  end

  # GET /dang_ky_day_bus/1
  # GET /dang_ky_day_bus/1.json
  def show
    @dang_ky_day_bu = DangKyDayBu.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dang_ky_day_bu }
    end
  end

  # GET /dang_ky_day_bus/new
  # GET /dang_ky_day_bus/new.json
  def new
    @dang_ky_day_bu = DangKyDayBu.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dang_ky_day_bu }
    end
  end

  # GET /dang_ky_day_bus/1/edit
  def edit
    @dang_ky_day_bu = DangKyDayBu.find(params[:id])
  end

  # POST /dang_ky_day_bus
  # POST /dang_ky_day_bus.json
  def create
    @dang_ky_day_bu = DangKyDayBu.new(params[:dang_ky_day_bu])

    respond_to do |format|
      if @dang_ky_day_bu.save
        format.html { redirect_to @dang_ky_day_bu, notice: 'Dang ky day bu was successfully created.' }
        format.json { render json: @dang_ky_day_bu, status: :created, location: @dang_ky_day_bu }
      else
        format.html { render action: "new" }
        format.json { render json: @dang_ky_day_bu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dang_ky_day_bus/1
  # PUT /dang_ky_day_bus/1.json
  def update
    @dang_ky_day_bu = DangKyDayBu.find(params[:id])

    respond_to do |format|
      if @dang_ky_day_bu.update_attributes(params[:dang_ky_day_bu])
        format.html { redirect_to @dang_ky_day_bu, notice: 'Dang ky day bu was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dang_ky_day_bu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dang_ky_day_bus/1
  # DELETE /dang_ky_day_bus/1.json
  def destroy
    @dang_ky_day_bu = DangKyDayBu.find(params[:id])
    @dang_ky_day_bu.destroy

    respond_to do |format|
      format.html { redirect_to dang_ky_day_bus_url }
      format.json { head :no_content }
    end
  end
end
