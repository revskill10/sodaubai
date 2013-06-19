class ThongBaoLopHocsController < ApplicationController
  before_filter :load_lop
  # GET /thong_bao_lop_hocs
  # GET /thong_bao_lop_hocs.json
  def index
    @thong_bao_lop_hocs = @lop_mon_hoc.thong_bao_lop_hocs

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @thong_bao_lop_hocs }
    end
  end

  # GET /thong_bao_lop_hocs/1
  # GET /thong_bao_lop_hocs/1.json
  def show
    @thong_bao_lop_hoc = @lop_mon_hoc.thong_bao_lop_hocs.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @thong_bao_lop_hoc }
    end
  end

  # GET /thong_bao_lop_hocs/new
  # GET /thong_bao_lop_hocs/new.json
  def new
    @thong_bao_lop_hoc = @lop_mon_hoc.thong_bao_lop_hocs.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @thong_bao_lop_hoc }
    end
  end

  # GET /thong_bao_lop_hocs/1/edit
  def edit
    @thong_bao_lop_hoc = @lop_mon_hoc.thong_bao_lop_hocs.find(params[:id])
  end

  # POST /thong_bao_lop_hocs
  # POST /thong_bao_lop_hocs.json
  def create
    @thong_bao_lop_hoc = @lop_mon_hoc.thong_bao_lop_hocs.build(params[:thong_bao_lop_hoc])

    respond_to do |format|
      if @thong_bao_lop_hoc.save
        format.html { redirect_to lop_mon_hoc_thong_bao_lop_hocs_path(@lop_mon_hoc), notice: 'Thong bao lop hoc was successfully created.' }
        format.json { render json: @thong_bao_lop_hoc, status: :created, location: @thong_bao_lop_hoc }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @thong_bao_lop_hoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /thong_bao_lop_hocs/1
  # PUT /thong_bao_lop_hocs/1.json
  def update
    @thong_bao_lop_hoc = @lop_mon_hoc.thong_bao_lop_hocs.find(params[:id])

    respond_to do |format|
      if @thong_bao_lop_hoc.update_attributes(params[:thong_bao_lop_hoc])
        format.html { redirect_to [@lop_mon_hoc,@thong_bao_lop_hoc], notice: 'Thong bao lop hoc was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @thong_bao_lop_hoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /thong_bao_lop_hocs/1
  # DELETE /thong_bao_lop_hocs/1.json
  def destroy
    @thong_bao_lop_hoc = @lop_mon_hoc.thong_bao_lop_hocs.find(params[:id])
    @thong_bao_lop_hoc.destroy

    respond_to do |format|
      format.html { redirect_to lop_mon_hoc_thong_bao_lop_hocs_url(@lop_mon_hoc) }
      format.json { head :no_content }
    end
  end

  protected
  def load_lop
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])
  end
end
