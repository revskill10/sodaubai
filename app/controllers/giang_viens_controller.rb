class GiangViensController < ApplicationController
  # GET /giang_viens
  # GET /giang_viens.json
  def index
    @giang_viens = GiangVien.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @giang_viens }
    end
  end

  # GET /giang_viens/1
  # GET /giang_viens/1.json
  def show
    @giang_vien = GiangVien.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @giang_vien }
    end
  end

  # GET /giang_viens/new
  # GET /giang_viens/new.json
  def new
    @giang_vien = GiangVien.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @giang_vien }
    end
  end

  # GET /giang_viens/1/edit
  def edit
    @giang_vien = GiangVien.find(params[:id])
  end

  # POST /giang_viens
  # POST /giang_viens.json
  def create
    @giang_vien = GiangVien.new(params[:giang_vien])

    respond_to do |format|
      if @giang_vien.save
        format.html { redirect_to @giang_vien, notice: 'Giang vien was successfully created.' }
        format.json { render json: @giang_vien, status: :created, location: @giang_vien }
      else
        format.html { render action: "new" }
        format.json { render json: @giang_vien.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /giang_viens/1
  # PUT /giang_viens/1.json
  def update
    @giang_vien = GiangVien.find(params[:id])

    respond_to do |format|
      if @giang_vien.update_attributes(params[:giang_vien])
        format.html { redirect_to @giang_vien, notice: 'Giang vien was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @giang_vien.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /giang_viens/1
  # DELETE /giang_viens/1.json
  def destroy
    @giang_vien = GiangVien.find(params[:id])
    @giang_vien.destroy

    respond_to do |format|
      format.html { redirect_to giang_viens_url }
      format.json { head :no_content }
    end
  end
end
