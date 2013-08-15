class Group < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :users,  :join_table => "users_groups"

  def to_s
  	name
  end
end
