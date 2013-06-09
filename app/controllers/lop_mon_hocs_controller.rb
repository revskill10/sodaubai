class LopMonHocsController < ApplicationController
  # GET /lop_mon_hocs
  # GET /lop_mon_hocs.json
  def index
    @lop_mon_hocs = LopMonHoc.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lop_mon_hocs }
    end
  end

  # GET /lop_mon_hocs/1
  # GET /lop_mon_hocs/1.json
  def show
    @lop_mon_hoc = LopMonHoc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lop_mon_hoc }
    end
  end

  # GET /lop_mon_hocs/new
  # GET /lop_mon_hocs/new.json
  def new
    @lop_mon_hoc = LopMonHoc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lop_mon_hoc }
    end
  end

  # GET /lop_mon_hocs/1/edit
  def edit
    @lop_mon_hoc = LopMonHoc.find(params[:id])
  end

  # POST /lop_mon_hocs
  # POST /lop_mon_hocs.json
  def create
    @lop_mon_hoc = LopMonHoc.new(params[:lop_mon_hoc])

    respond_to do |format|
      if @lop_mon_hoc.save
        format.html { redirect_to @lop_mon_hoc, notice: 'Lop mon hoc was successfully created.' }
        format.json { render json: @lop_mon_hoc, status: :created, location: @lop_mon_hoc }
      else
        format.html { render action: "new" }
        format.json { render json: @lop_mon_hoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lop_mon_hocs/1
  # PUT /lop_mon_hocs/1.json
  def update
    @lop_mon_hoc = LopMonHoc.find(params[:id])

    respond_to do |format|
      if @lop_mon_hoc.update_attributes(params[:lop_mon_hoc])
        format.html { redirect_to @lop_mon_hoc, notice: 'Lop mon hoc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lop_mon_hoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lop_mon_hocs/1
  # DELETE /lop_mon_hocs/1.json
  def destroy
    @lop_mon_hoc = LopMonHoc.find(params[:id])
    @lop_mon_hoc.destroy

    respond_to do |format|
      format.html { redirect_to lop_mon_hocs_url }
      format.json { head :no_content }
    end
  end
end
