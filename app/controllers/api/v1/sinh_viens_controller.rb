class API::V1::SinhViensController < ApplicationController
  # GET /sinh_viens
  # GET /sinh_viens.json
  def index
    @sinh_viens = SinhVien.all

    respond_to do |format|      
      format.json { render json: @sinh_viens }
    end
  end

  # GET /sinh_viens/1
  # GET /sinh_viens/1.json
  def show
    @sinh_vien = SinhVien.find(params[:id])

    respond_to do |format|      
      format.json { render json: @sinh_vien }
    end
  end

  # GET /sinh_viens/new
  # GET /sinh_viens/new.json
  def new
    @sinh_vien = SinhVien.new

    respond_to do |format|      
      format.json { render json: @sinh_vien }
    end
  end

  # GET /sinh_viens/1/edit
  def edit
    @sinh_vien = SinhVien.find(params[:id])
  end

  # POST /sinh_viens
  # POST /sinh_viens.json
  def create
    @sinh_vien = SinhVien.new(params[:sinh_vien])

    respond_to do |format|
      if @sinh_vien.save        
        format.json { render json: @sinh_vien, status: :created, location: @sinh_vien }
      else        
        format.json { render json: @sinh_vien.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sinh_viens/1
  # PUT /sinh_viens/1.json
  def update
    @sinh_vien = SinhVien.find(params[:id])

    respond_to do |format|
      if @sinh_vien.update_attributes(params[:sinh_vien])        
        format.json { head :no_content }
      else        
        format.json { render json: @sinh_vien.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sinh_viens/1
  # DELETE /sinh_viens/1.json
  def destroy
    @sinh_vien = SinhVien.find(params[:id])
    @sinh_vien.destroy

    respond_to do |format|      
      format.json { head :no_content }
    end
  end
    
end
