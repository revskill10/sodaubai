class NhatKiesController < ApplicationController
  # GET /nhat_kies
  # GET /nhat_kies.json
  def index
    @nhat_kies = NhatKy.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nhat_kies }
    end
  end

  # GET /nhat_kies/1
  # GET /nhat_kies/1.json
  def show
    @nhat_ky = NhatKy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nhat_ky }
    end
  end

  # GET /nhat_kies/new
  # GET /nhat_kies/new.json
  def new
    @nhat_ky = NhatKy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nhat_ky }
    end
  end

  # GET /nhat_kies/1/edit
  def edit
    @nhat_ky = NhatKy.find(params[:id])
  end

  # POST /nhat_kies
  # POST /nhat_kies.json
  def create
    @nhat_ky = NhatKy.new(params[:nhat_ky])

    respond_to do |format|
      if @nhat_ky.save
        format.html { redirect_to @nhat_ky, notice: 'Nhat ky was successfully created.' }
        format.json { render json: @nhat_ky, status: :created, location: @nhat_ky }
      else
        format.html { render action: "new" }
        format.json { render json: @nhat_ky.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nhat_kies/1
  # PUT /nhat_kies/1.json
  def update
    @nhat_ky = NhatKy.find(params[:id])

    respond_to do |format|
      if @nhat_ky.update_attributes(params[:nhat_ky])
        format.html { redirect_to @nhat_ky, notice: 'Nhat ky was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nhat_ky.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nhat_kies/1
  # DELETE /nhat_kies/1.json
  def destroy
    @nhat_ky = NhatKy.find(params[:id])
    @nhat_ky.destroy

    respond_to do |format|
      format.html { redirect_to nhat_kies_url }
      format.json { head :no_content }
    end
  end
end
