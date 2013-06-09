class NghiDaysController < ApplicationController
  # GET /nghi_days
  # GET /nghi_days.json
  def index
    @nghi_days = NghiDay.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nghi_days }
    end
  end

  # GET /nghi_days/1
  # GET /nghi_days/1.json
  def show
    @nghi_day = NghiDay.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nghi_day }
    end
  end

  # GET /nghi_days/new
  # GET /nghi_days/new.json
  def new
    @nghi_day = NghiDay.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nghi_day }
    end
  end

  # GET /nghi_days/1/edit
  def edit
    @nghi_day = NghiDay.find(params[:id])
  end

  # POST /nghi_days
  # POST /nghi_days.json
  def create
    @nghi_day = NghiDay.new(params[:nghi_day])

    respond_to do |format|
      if @nghi_day.save
        format.html { redirect_to @nghi_day, notice: 'Nghi day was successfully created.' }
        format.json { render json: @nghi_day, status: :created, location: @nghi_day }
      else
        format.html { render action: "new" }
        format.json { render json: @nghi_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nghi_days/1
  # PUT /nghi_days/1.json
  def update
    @nghi_day = NghiDay.find(params[:id])

    respond_to do |format|
      if @nghi_day.update_attributes(params[:nghi_day])
        format.html { redirect_to @nghi_day, notice: 'Nghi day was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nghi_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nghi_days/1
  # DELETE /nghi_days/1.json
  def destroy
    @nghi_day = NghiDay.find(params[:id])
    @nghi_day.destroy

    respond_to do |format|
      format.html { redirect_to nghi_days_url }
      format.json { head :no_content }
    end
  end
end
