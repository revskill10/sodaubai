class Post < ActiveRecord::Base
  attr_accessible :body, :lop_mon_hoc_id, :topic_id, :user_id

  belongs_to :lop_mon_hoc, :counter_cache => true
  belongs_to :topic, :counter_cache => true, :touch => true
  belongs_to :user

  # Accessors
  attr_accessible :body
  
  # Validations
  validates :body, :presence => true
  validates :user, :presence => true

  # Default Scope
  default_scope :order => 'created_at ASC'

   # Scope to display only the last n posts. Used for "Recent Posts" display
  scope :recent, lambda {
    |c| reorder('created_at desc').limit(c)
  }

  # Callbacks
  before_save :topic_locked?
  after_create :cache_user
  def topic_locked?
      if topic.locked?
        errors.add(:base, "That topic is locked")
        false
      end
    end
  private
  def cache_user
  	if user and user.imageable
  		user.imageable.posts_count ||= 0
  		user.imageable.posts_count += 1
  		user.imageable.save! rescue puts "error save cache"  		
  	end
  end
end
