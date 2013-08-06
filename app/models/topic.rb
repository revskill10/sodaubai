class Topic < ActiveRecord::Base
  attr_accessible :locked, :lop_mon_hoc_id, :posts_count, :title, :body, :user_id

  attr_accessor :body

  has_many :posts, :dependent => :destroy
  belongs_to :lop_mon_hoc, :counter_cache => true
  belongs_to :user

  validates :title, :presence => true
  validates :body, :presence => true, :on => :create
  validates :posts, :presence => true, :allow_nil => false, :on => :update
  validates :user, :presence => true

  default_scope :order => 'updated_at DESC'
  after_create :create_initial_post

  private
    def create_initial_post
      return self.posts.build(:body => self.body) do |post|
        post.lop_mon_hoc = self.lop_mon_hoc
        post.user = self.user
        if self.user.imageable
	        self.user.imageable.topics_count ||= 0 
	        self.user.imageable.topics_count += 1 	        
	      end
        post.save
      end
    end
end
