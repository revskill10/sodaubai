class LichTrinhGiangDaysController < ApplicationController
  # GET /lich_trinh_giang_days
  # GET /lich_trinh_giang_days.json
  def index
    @lich_trinh_giang_days = LichTrinhGiangDay.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lich_trinh_giang_days }
    end
  end

  # GET /lich_trinh_giang_days/1
  # GET /lich_trinh_giang_days/1.json
  def show
    @lich_trinh_giang_day = LichTrinhGiangDay.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lich_trinh_giang_day }
    end
  end

  # GET /lich_trinh_giang_days/new
  # GET /lich_trinh_giang_days/new.json
  def new
    @lich_trinh_giang_day = LichTrinhGiangDay.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lich_trinh_giang_day }
    end
  end

  # GET /lich_trinh_giang_days/1/edit
  def edit
    @lich_trinh_giang_day = LichTrinhGiangDay.find(params[:id])
  end

  # POST /lich_trinh_giang_days
  # POST /lich_trinh_giang_days.json
  def create
    @lich_trinh_giang_day = LichTrinhGiangDay.new(params[:lich_trinh_giang_day])

    respond_to do |format|
      if @lich_trinh_giang_day.save
        format.html { redirect_to @lich_trinh_giang_day, notice: 'Lich trinh giang day was successfully created.' }
        format.json { render json: @lich_trinh_giang_day, status: :created, location: @lich_trinh_giang_day }
      else
        format.html { render action: "new" }
        format.json { render json: @lich_trinh_giang_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lich_trinh_giang_days/1
  # PUT /lich_trinh_giang_days/1.json
  def update
    @lich_trinh_giang_day = LichTrinhGiangDay.find(params[:id])

    respond_to do |format|
      if @lich_trinh_giang_day.update_attributes(params[:lich_trinh_giang_day])
        format.html { redirect_to @lich_trinh_giang_day, notice: 'Lich trinh giang day was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lich_trinh_giang_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lich_trinh_giang_days/1
  # DELETE /lich_trinh_giang_days/1.json
  def destroy
    @lich_trinh_giang_day = LichTrinhGiangDay.find(params[:id])
    @lich_trinh_giang_day.destroy

    respond_to do |format|
      format.html { redirect_to lich_trinh_giang_days_url }
      format.json { head :no_content }
    end
  end
end
