class MonHocsController < ApplicationController
  # GET /mon_hocs
  # GET /mon_hocs.json
  def index
    @mon_hocs = MonHoc.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mon_hocs }
    end
  end

  # GET /mon_hocs/1
  # GET /mon_hocs/1.json
  def show
    @mon_hoc = MonHoc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mon_hoc }
    end
  end

  # GET /mon_hocs/new
  # GET /mon_hocs/new.json
  def new
    @mon_hoc = MonHoc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mon_hoc }
    end
  end

  # GET /mon_hocs/1/edit
  def edit
    @mon_hoc = MonHoc.find(params[:id])
  end

  # POST /mon_hocs
  # POST /mon_hocs.json
  def create
    @mon_hoc = MonHoc.new(params[:mon_hoc])

    respond_to do |format|
      if @mon_hoc.save
        format.html { redirect_to @mon_hoc, notice: 'Mon hoc was successfully created.' }
        format.json { render json: @mon_hoc, status: :created, location: @mon_hoc }
      else
        format.html { render action: "new" }
        format.json { render json: @mon_hoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mon_hocs/1
  # PUT /mon_hocs/1.json
  def update
    @mon_hoc = MonHoc.find(params[:id])

    respond_to do |format|
      if @mon_hoc.update_attributes(params[:mon_hoc])
        format.html { redirect_to @mon_hoc, notice: 'Mon hoc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mon_hoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mon_hocs/1
  # DELETE /mon_hocs/1.json
  def destroy
    @mon_hoc = MonHoc.find(params[:id])
    @mon_hoc.destroy

    respond_to do |format|
      format.html { redirect_to mon_hocs_url }
      format.json { head :no_content }
    end
  end
end
