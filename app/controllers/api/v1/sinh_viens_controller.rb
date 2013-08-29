require 'pg_tools'
class API::V1::SinhViensController < ActionController::Base
  # GET /sinh_viens
  # GET /sinh_viens.json
  before_filter :load_tenant
  def index
    @sinh_viens = SinhVien.all

    respond_to do |format|      
      format.json { render json: @sinh_viens }
    end
  end  
  # GET /sinh_viens/1
  # GET /sinh_viens/1.json
  def show
    @sinh_vien = SinhVien.where(ma_sinh_vien: params[:id]).first
    if @sinh_vien and @sinh_vien.trucnhat
      respond_to do |format|      
        format.json { render json: JSON.parse(@sinh_vien.trucnhat)["days"].sort_by }
      end
    else
      respond_to do |format|      
        format.json { render json: nil }
      end
    end
  end

  def tkb
    @sinh_vien = SinhVien.where(ma_sinh_vien: params[:id]).first
    if @sinh_vien
      @current_lops = @sinh_vien.lop_mon_hocs      
      @lich = @sinh_vien.get_days[:ngay].uniq if @sinh_vien.get_days
      respond_to do |format|      
        format.json { render json: @lich }
      end
    else
      respond_to do |format|      
        format.json { render json: nil }
      end
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
  
  def load_tenant

    if @current_tenant ||= Tenant.last     
      PgTools.set_search_path @current_tenant.scheme    
     
    else
      PgTools.restore_default_search_path
     
    end
  end
end
