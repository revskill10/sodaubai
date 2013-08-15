# encoding: UTF-8
class LopMonHocSinhViensController < ApplicationController
  # GET /lop_mon_hoc_sinh_viens
  # GET /lop_mon_hoc_sinh_viens.json
  before_filter :load_lop

  def groupupdate
    @msvs = params[:nhom].keys
    #puts msvs.inspect
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens.select {|k| @msvs.include?(k.ma_sinh_vien)}
    @temp = JSON.parse(@lop_mon_hoc.group_diem) if @lop_mon_hoc.group_diem
    
    @svs.each do |sv|
      sv.group_id = params[:nhom][sv.ma_sinh_vien].to_i
      if @temp
        diem_nhom = @temp[sv.group_id.to_s]      
        sv.diem_thuc_hanh = diem_nhom
      end
      sv.save! rescue "error update nhom"
    end
    
    #params["nhom"].each do |k,v|
     # sv = @svs.select {|s| s.ma_sinh_vien == k}.first
      #if sv then 
       # sv.group_id = v.to_i
        #sv.save! rescue "Save group error"
      #end
    #end
    #puts params.inspect
    respond_to do |format|
      format.js
    end
  end
  def index
    #@lop_mon_hoc_sinh_viens = LopMonHocSinhVien.all
    @lop_mon_hoc_sinh_viens = @lop_mon_hoc.lop_mon_hoc_sinh_viens

    if @lop_mon_hoc.group.nil? then 
      @lop_mon_hoc.group = 1
      @lop_mon_hoc.save!
    end 
    @group = @lop_mon_hoc.group
    @groups_arrays = {}
    @group.times do |g|
      @groups_arrays[(g+1).to_s] = "Nhóm #{g+1}"
    end
    #@groups_arrays = @groups.map {|gr| ["Group #{gr.id}", gr.id] }
    respond_to do |format|
      format.html { render :layout => false if request.headers['X-PJAX']}
      format.json { render json: @lop_mon_hoc_sinh_viens }
    end
    
  end

  def group
    #@lop_mon_hoc_sinh_viens = LopMonHocSinhVien.all
    @lop_mon_hoc_sinh_viens = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    @group = @lop_mon_hoc.group || 1
    @groups_arrays = {}
    @group.times do |g|
      @groups_arrays[(g+1).to_s] = "Nhóm #{g+1}"
    end
    #@groups_arrays = @groups.map {|gr| ["Group #{gr.id}", gr.id] }
    respond_to do |format|
      format.html { render :layout => false if request.headers['X-PJAX']}
      format.json { render json: @lop_mon_hoc_sinh_viens }
    end
    
  end

  # GET /lop_mon_hoc_sinh_viens/1
  # GET /lop_mon_hoc_sinh_viens/1.json
  def show
    authorize! :read, @lop_mon_hoc
    @lop_mon_hoc_sinh_vien = @lop_mon_hoc.get_sinh_viens.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false if request.headers['X-PJAX']}
      format.json { render json: @lop_mon_hoc_sinh_vien }
    end
  end

  # GET /lop_mon_hoc_sinh_viens/new
  # GET /lop_mon_hoc_sinh_viens/new.json
  def new
    authorize! :manage, @lop_mon_hoc
    @lop_mon_hoc_sinh_vien = @lop_mon_hoc.lop_mon_hoc_sinh_viens.build

    respond_to do |format|
      format.html { render :layout => (request.headers['X-PJAX'] ? false : true)}
      format.json { render json: @lop_mon_hoc_sinh_vien }
    end
  end

  # GET /lop_mon_hoc_sinh_viens/1/edit
  def edit
    @lop_mon_hoc_sinh_vien = @lop_mon_hoc.get_sinh_viens.find(params[:id])
  end
  
  # POST /lop_mon_hoc_sinh_viens
  # POST /lop_mon_hoc_sinh_viens.json
  def create    
    authorize! :manage, @lop_mon_hoc
    msv = params[:lop_mon_hoc_sinh_vien][:ma_sinh_vien]
    @sv = SinhVien.where(ma_sinh_vien: msv).first
    @lop_mon_hoc_sinh_vien = @lop_mon_hoc.lop_mon_hoc_sinh_viens.build(ma_sinh_vien: params[:lop_mon_hoc_sinh_vien][:ma_sinh_vien])
    @lop_mon_hoc_sinh_vien.ma_mon_hoc = @lop_mon_hoc.ma_mon_hoc
    @lop_mon_hoc_sinh_vien.ten_mon_hoc = @lop_mon_hoc.ten_mon_hoc
    @lop_mon_hoc_sinh_vien.ma_lop_hanh_chinh = @sv.lop_hc
    @lop_mon_hoc_sinh_vien.ma_lop = @lop_mon_hoc.ma_lop
    @lop_mon_hoc_sinh_vien.ma_lop_ghep = @lop_mon_hoc.ma_lop
    hodem = @sv.ho_dem.split(" ").to_a
    dem = hodem.last
    ho = hodem.first
    @lop_mon_hoc_sinh_vien.ho = ho 
    @lop_mon_hoc_sinh_vien.ho_dem = dem
    respond_to do |format|
      if @sv 
        @tt = @sv.check_conflict(@lop_mon_hoc) 
        if @tt
          format.js {render :conflict}
        else 
          if params[:checksv]
            format.js {render :checksv}
          elsif params[:submit]
            if  @lop_mon_hoc_sinh_vien.save!
              format.js
              format.html { flash[:success] = "Created OK";
                render :index, :layout => (request.headers['X-PJAX'] ? false : true)  }
              format.json { render json: @lop_mon_hoc_sinh_vien, status: :created, location: @lop_mon_hoc_sinh_vien }
            end
          end
        end
      else
        format.js
        format.html { render action: "new" }
        format.json { render json: @lop_mon_hoc_sinh_vien.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lop_mon_hoc_sinh_viens/1
  # PUT /lop_mon_hoc_sinh_viens/1.json
  def update
    authorize! :manage, @lop_mon_hoc
    @lop_mon_hoc_sinh_vien = @lop_mon_hoc.lop_mon_hoc_sinh_viens.find(params[:id])

    respond_to do |format|
      if @lop_mon_hoc_sinh_vien.update_attributes(params[:lop_mon_hoc_sinh_vien])
        format.js
        format.html { redirect_to [@lop_mon_hoc,@lop_mon_hoc_sinh_vien], notice: 'Lop mon hoc sinh vien was successfully updated.' }
        format.json { head :no_content }
      else
        format.js
        format.html { render action: "edit" }
        format.json { render json: @lop_mon_hoc_sinh_vien.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lop_mon_hoc_sinh_viens/1
  # DELETE /lop_mon_hoc_sinh_viens/1.json
  def destroy
    authorize! :manage, @lop_mon_hoc
    @lop_mon_hoc_sinh_vien = @lop_mon_hoc.lop_mon_hoc_sinh_viens.find(params[:id])
    @lop_mon_hoc_sinh_vien.status = true
    @lop_mon_hoc_sinh_vien.save! rescue puts "error"

    respond_to do |format|
      format.js 
      format.html { redirect_to lop_mon_hoc_lop_mon_hoc_sinh_viens_url(@lop_mon_hoc) }
      format.json { head :no_content }
    end
  end

  protected
  def load_lop
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])      
    @malop = @lop_mon_hoc.ma_lop
    @mamonhoc = @lop_mon_hoc.ma_mon_hoc
  end
end
