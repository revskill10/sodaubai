class ThongBaoLopHocsController < ApplicationController
  # GET /thong_bao_lop_hocs
  # GET /thong_bao_lop_hocs.json
  def index
    @thong_bao_lop_hocs = ThongBaoLopHoc.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @thong_bao_lop_hocs }
    end
  end

  # GET /thong_bao_lop_hocs/1
  # GET /thong_bao_lop_hocs/1.json
  def show
    @thong_bao_lop_hoc = ThongBaoLopHoc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @thong_bao_lop_hoc }
    end
  end

  # GET /thong_bao_lop_hocs/new
  # GET /thong_bao_lop_hocs/new.json
  def new
    @thong_bao_lop_hoc = ThongBaoLopHoc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @thong_bao_lop_hoc }
    end
  end

  # GET /thong_bao_lop_hocs/1/edit
  def edit
    @thong_bao_lop_hoc = ThongBaoLopHoc.find(params[:id])
  end

  # POST /thong_bao_lop_hocs
  # POST /thong_bao_lop_hocs.json
  def create
    @thong_bao_lop_hoc = ThongBaoLopHoc.new(params[:thong_bao_lop_hoc])

    respond_to do |format|
      if @thong_bao_lop_hoc.save
        format.html { redirect_to @thong_bao_lop_hoc, notice: 'Thong bao lop hoc was successfully created.' }
        format.json { render json: @thong_bao_lop_hoc, status: :created, location: @thong_bao_lop_hoc }
      else
        format.html { render action: "new" }
        format.json { render json: @thong_bao_lop_hoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /thong_bao_lop_hocs/1
  # PUT /thong_bao_lop_hocs/1.json
  def update
    @thong_bao_lop_hoc = ThongBaoLopHoc.find(params[:id])

    respond_to do |format|
      if @thong_bao_lop_hoc.update_attributes(params[:thong_bao_lop_hoc])
        format.html { redirect_to @thong_bao_lop_hoc, notice: 'Thong bao lop hoc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @thong_bao_lop_hoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /thong_bao_lop_hocs/1
  # DELETE /thong_bao_lop_hocs/1.json
  def destroy
    @thong_bao_lop_hoc = ThongBaoLopHoc.find(params[:id])
    @thong_bao_lop_hoc.destroy

    respond_to do |format|
      format.html { redirect_to thong_bao_lop_hocs_url }
      format.json { head :no_content }
    end
  end
end
