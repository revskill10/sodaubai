class KienNghisController < ApplicationController
  # GET /kien_nghis
  # GET /kien_nghis.json
  def index
    @kien_nghis = KienNghi.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @kien_nghis }
    end
  end

  # GET /kien_nghis/1
  # GET /kien_nghis/1.json
  def show
    @kien_nghi = KienNghi.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @kien_nghi }
    end
  end

  # GET /kien_nghis/new
  # GET /kien_nghis/new.json
  def new
    @kien_nghi = KienNghi.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @kien_nghi }
    end
  end

  # GET /kien_nghis/1/edit
  def edit
    @kien_nghi = KienNghi.find(params[:id])
  end

  # POST /kien_nghis
  # POST /kien_nghis.json
  def create
    @kien_nghi = KienNghi.new(params[:kien_nghi])

    respond_to do |format|
      if @kien_nghi.save
        format.html { redirect_to @kien_nghi, notice: 'Kien nghi was successfully created.' }
        format.json { render json: @kien_nghi, status: :created, location: @kien_nghi }
      else
        format.html { render action: "new" }
        format.json { render json: @kien_nghi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /kien_nghis/1
  # PUT /kien_nghis/1.json
  def update
    @kien_nghi = KienNghi.find(params[:id])

    respond_to do |format|
      if @kien_nghi.update_attributes(params[:kien_nghi])
        format.html { redirect_to @kien_nghi, notice: 'Kien nghi was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @kien_nghi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kien_nghis/1
  # DELETE /kien_nghis/1.json
  def destroy
    @kien_nghi = KienNghi.find(params[:id])
    @kien_nghi.destroy

    respond_to do |format|
      format.html { redirect_to kien_nghis_url }
      format.json { head :no_content }
    end
  end
end
