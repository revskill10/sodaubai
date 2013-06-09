class RaSomVaoMuonsController < ApplicationController
  # GET /ra_som_vao_muons
  # GET /ra_som_vao_muons.json
  def index
    @ra_som_vao_muons = RaSomVaoMuon.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ra_som_vao_muons }
    end
  end

  # GET /ra_som_vao_muons/1
  # GET /ra_som_vao_muons/1.json
  def show
    @ra_som_vao_muon = RaSomVaoMuon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ra_som_vao_muon }
    end
  end

  # GET /ra_som_vao_muons/new
  # GET /ra_som_vao_muons/new.json
  def new
    @ra_som_vao_muon = RaSomVaoMuon.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ra_som_vao_muon }
    end
  end

  # GET /ra_som_vao_muons/1/edit
  def edit
    @ra_som_vao_muon = RaSomVaoMuon.find(params[:id])
  end

  # POST /ra_som_vao_muons
  # POST /ra_som_vao_muons.json
  def create
    @ra_som_vao_muon = RaSomVaoMuon.new(params[:ra_som_vao_muon])

    respond_to do |format|
      if @ra_som_vao_muon.save
        format.html { redirect_to @ra_som_vao_muon, notice: 'Ra som vao muon was successfully created.' }
        format.json { render json: @ra_som_vao_muon, status: :created, location: @ra_som_vao_muon }
      else
        format.html { render action: "new" }
        format.json { render json: @ra_som_vao_muon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ra_som_vao_muons/1
  # PUT /ra_som_vao_muons/1.json
  def update
    @ra_som_vao_muon = RaSomVaoMuon.find(params[:id])

    respond_to do |format|
      if @ra_som_vao_muon.update_attributes(params[:ra_som_vao_muon])
        format.html { redirect_to @ra_som_vao_muon, notice: 'Ra som vao muon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ra_som_vao_muon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ra_som_vao_muons/1
  # DELETE /ra_som_vao_muons/1.json
  def destroy
    @ra_som_vao_muon = RaSomVaoMuon.find(params[:id])
    @ra_som_vao_muon.destroy

    respond_to do |format|
      format.html { redirect_to ra_som_vao_muons_url }
      format.json { head :no_content }
    end
  end
end
