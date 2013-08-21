class API::V1::GiangViensController < ApplicationController
  # GET /sinh_viens
  # GET /sinh_viens.json
  def index
    @giang_viens = GiangVien.all

    respond_to do |format|      
      format.json { render json: @giang_viens }
    end
  end

  # GET /sinh_viens/1
  # GET /sinh_viens/1.json
  def show
    @giang_vien = GiangVien.find(params[:id])

    respond_to do |format|      
      format.json { render json: @giang_vien }
    end
  end

  # GET /sinh_viens/new
  # GET /sinh_viens/new.json
  def new
    @giang_vien = GiangVien.new

    respond_to do |format|      
      format.json { render json: @giang_vien }
    end
  end

  # GET /sinh_viens/1/edit
  def edit
    @giang_vien = GiangVien.find(params[:id])
  end

  # POST /sinh_viens
  # POST /sinh_viens.json
  def create
    @giang_vien = GiangVien.new(params[:giang_vien])

    respond_to do |format|
      if @giang_vien.save        
        format.json { render json: @giang_vien, status: :created, location: @giang_vien }
      else        
        format.json { render json: @giang_vien.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sinh_viens/1
  # PUT /sinh_viens/1.json
  def update
    @giang_vien = GiangVien.find(params[:id])

    respond_to do |format|
      if @giang_vien.update_attributes(params[:giang_vien])        
        format.json { head :no_content }
      else        
        format.json { render json: @giang_vien.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sinh_viens/1
  # DELETE /sinh_viens/1.json
  def destroy
    @giang_vien = GiangVien.find(params[:id])
    @giang_vien.destroy

    respond_to do |format|      
      format.json { head :no_content }
    end
  end
    
end
