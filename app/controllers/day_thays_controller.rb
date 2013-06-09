class DayThaysController < ApplicationController
  # GET /day_thays
  # GET /day_thays.json
  def index
    @day_thays = DayThay.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @day_thays }
    end
  end

  # GET /day_thays/1
  # GET /day_thays/1.json
  def show
    @day_thay = DayThay.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @day_thay }
    end
  end

  # GET /day_thays/new
  # GET /day_thays/new.json
  def new
    @day_thay = DayThay.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @day_thay }
    end
  end

  # GET /day_thays/1/edit
  def edit
    @day_thay = DayThay.find(params[:id])
  end

  # POST /day_thays
  # POST /day_thays.json
  def create
    @day_thay = DayThay.new(params[:day_thay])

    respond_to do |format|
      if @day_thay.save
        format.html { redirect_to @day_thay, notice: 'Day thay was successfully created.' }
        format.json { render json: @day_thay, status: :created, location: @day_thay }
      else
        format.html { render action: "new" }
        format.json { render json: @day_thay.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /day_thays/1
  # PUT /day_thays/1.json
  def update
    @day_thay = DayThay.find(params[:id])

    respond_to do |format|
      if @day_thay.update_attributes(params[:day_thay])
        format.html { redirect_to @day_thay, notice: 'Day thay was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @day_thay.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /day_thays/1
  # DELETE /day_thays/1.json
  def destroy
    @day_thay = DayThay.find(params[:id])
    @day_thay.destroy

    respond_to do |format|
      format.html { redirect_to day_thays_url }
      format.json { head :no_content }
    end
  end
end
