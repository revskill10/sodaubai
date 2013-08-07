class PostsController < ApplicationController
	before_filter :load_lop_and_topic

  def new

  end
  def create
    @post = @topic.posts.build(params[:post])
    @post.user = current_user
    @post.save! rescue    puts "Error create post"
    respond_to do |format|
      format.js
    end
  end
  def edit

  end
  def update

  end
  def destroy
    @post = @topic.posts.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.js
    end
  end
	private
  def load_lop_and_topic
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])
    @topic = @lop_mon_hoc.topics.find(params[:topic_id])
  end
end
