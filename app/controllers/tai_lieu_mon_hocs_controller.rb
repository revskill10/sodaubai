class TaiLieuMonHocsController < ApplicationController
  # GET /tai_lieu_mon_hocs
  # GET /tai_lieu_mon_hocs.json
  def index
    @tai_lieu_mon_hocs = TaiLieuMonHoc.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tai_lieu_mon_hocs }
    end
  end

  # GET /tai_lieu_mon_hocs/1
  # GET /tai_lieu_mon_hocs/1.json
  def show
    @tai_lieu_mon_hoc = TaiLieuMonHoc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tai_lieu_mon_hoc }
    end
  end

  # GET /tai_lieu_mon_hocs/new
  # GET /tai_lieu_mon_hocs/new.json
  def new
    @tai_lieu_mon_hoc = TaiLieuMonHoc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tai_lieu_mon_hoc }
    end
  end

  # GET /tai_lieu_mon_hocs/1/edit
  def edit
    @tai_lieu_mon_hoc = TaiLieuMonHoc.find(params[:id])
  end

  # POST /tai_lieu_mon_hocs
  # POST /tai_lieu_mon_hocs.json
  def create
    @tai_lieu_mon_hoc = TaiLieuMonHoc.new(params[:tai_lieu_mon_hoc])

    respond_to do |format|
      if @tai_lieu_mon_hoc.save
        format.html { redirect_to @tai_lieu_mon_hoc, notice: 'Tai lieu mon hoc was successfully created.' }
        format.json { render json: @tai_lieu_mon_hoc, status: :created, location: @tai_lieu_mon_hoc }
      else
        format.html { render action: "new" }
        format.json { render json: @tai_lieu_mon_hoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tai_lieu_mon_hocs/1
  # PUT /tai_lieu_mon_hocs/1.json
  def update
    @tai_lieu_mon_hoc = TaiLieuMonHoc.find(params[:id])

    respond_to do |format|
      if @tai_lieu_mon_hoc.update_attributes(params[:tai_lieu_mon_hoc])
        format.html { redirect_to @tai_lieu_mon_hoc, notice: 'Tai lieu mon hoc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tai_lieu_mon_hoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tai_lieu_mon_hocs/1
  # DELETE /tai_lieu_mon_hocs/1.json
  def destroy
    @tai_lieu_mon_hoc = TaiLieuMonHoc.find(params[:id])
    @tai_lieu_mon_hoc.destroy

    respond_to do |format|
      format.html { redirect_to tai_lieu_mon_hocs_url }
      format.json { head :no_content }
    end
  end
end
