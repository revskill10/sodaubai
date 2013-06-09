class CanBoLopsController < ApplicationController
  # GET /can_bo_lops
  # GET /can_bo_lops.json
  def index
    @can_bo_lops = CanBoLop.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @can_bo_lops }
    end
  end

  # GET /can_bo_lops/1
  # GET /can_bo_lops/1.json
  def show
    @can_bo_lop = CanBoLop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @can_bo_lop }
    end
  end

  # GET /can_bo_lops/new
  # GET /can_bo_lops/new.json
  def new
    @can_bo_lop = CanBoLop.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @can_bo_lop }
    end
  end

  # GET /can_bo_lops/1/edit
  def edit
    @can_bo_lop = CanBoLop.find(params[:id])
  end

  # POST /can_bo_lops
  # POST /can_bo_lops.json
  def create
    @can_bo_lop = CanBoLop.new(params[:can_bo_lop])

    respond_to do |format|
      if @can_bo_lop.save
        format.html { redirect_to @can_bo_lop, notice: 'Can bo lop was successfully created.' }
        format.json { render json: @can_bo_lop, status: :created, location: @can_bo_lop }
      else
        format.html { render action: "new" }
        format.json { render json: @can_bo_lop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /can_bo_lops/1
  # PUT /can_bo_lops/1.json
  def update
    @can_bo_lop = CanBoLop.find(params[:id])

    respond_to do |format|
      if @can_bo_lop.update_attributes(params[:can_bo_lop])
        format.html { redirect_to @can_bo_lop, notice: 'Can bo lop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @can_bo_lop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /can_bo_lops/1
  # DELETE /can_bo_lops/1.json
  def destroy
    @can_bo_lop = CanBoLop.find(params[:id])
    @can_bo_lop.destroy

    respond_to do |format|
      format.html { redirect_to can_bo_lops_url }
      format.json { head :no_content }
    end
  end
end
