class API::V1::TkbGiangViensController < ApplicationController
  # GET /tkb_giang_viens
  # GET /tkb_giang_viens.json
  def index
    @tkb_giang_viens = TkbGiangVien.all

    respond_to do |format|      
      format.json { render json: @tkb_giang_viens }
    end
  end

  # GET /tkb_giang_viens/1
  # GET /tkb_giang_viens/1.json
  def show
    @tkb_giang_vien = TkbGiangVien.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tkb_giang_vien }
    end
  end

  # GET /tkb_giang_viens/new
  # GET /tkb_giang_viens/new.json
  def new
    @tkb_giang_vien = TkbGiangVien.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tkb_giang_vien }
    end
  end

  # GET /tkb_giang_viens/1/edit
  def edit
    @tkb_giang_vien = TkbGiangVien.find(params[:id])
  end

  # POST /tkb_giang_viens
  # POST /tkb_giang_viens.json
  def create
    @tkb_giang_vien = TkbGiangVien.new(params[:tkb_giang_vien])

    respond_to do |format|
      if @tkb_giang_vien.save
        format.html { redirect_to @tkb_giang_vien, notice: 'Tkb giang vien was successfully created.' }
        format.json { render json: @tkb_giang_vien, status: :created, location: @tkb_giang_vien }
      else
        format.html { render action: "new" }
        format.json { render json: @tkb_giang_vien.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tkb_giang_viens/1
  # PUT /tkb_giang_viens/1.json
  def update
    @tkb_giang_vien = TkbGiangVien.find(params[:id])

    respond_to do |format|
      if @tkb_giang_vien.update_attributes(params[:tkb_giang_vien])
        format.html { redirect_to @tkb_giang_vien, notice: 'Tkb giang vien was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tkb_giang_vien.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tkb_giang_viens/1
  # DELETE /tkb_giang_viens/1.json
  def destroy
    @tkb_giang_vien = TkbGiangVien.find(params[:id])
    @tkb_giang_vien.destroy

    respond_to do |format|
      format.html { redirect_to tkb_giang_viens_url }
      format.json { head :no_content }
    end
  end
end
