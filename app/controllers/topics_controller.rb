class TopicsController < ApplicationController
  before_filter :load_lop
  # GET /topics
  # GET /topics.json
  def index
    @topics = @lop_mon_hoc.topics

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = @lop_mon_hoc.topics.find(params[:id])
    @posts = @topic.posts
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = @lop_mon_hoc.topics.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = @lop_mon_hoc.topics.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = @lop_mon_hoc.topics.build(params[:topic])
    @topic.user ||= current_user
    
    respond_to do |format|
      if @topic.save
        format.html { redirect_to lop_mon_hoc_topics_path(@lop_mon_hoc), notice: 'Thong bao lop hoc was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = @lop_mon_hoc.topics.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to [@lop_mon_hoc,@topic], notice: 'Thong bao lop hoc was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = @lop_mon_hoc.topics.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to lop_mon_hoc_topics_url(@lop_mon_hoc) }
      format.json { head :no_content }
    end
  end

  protected
  def load_lop
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])
  end
end
