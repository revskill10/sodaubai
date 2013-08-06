class Group < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :users

  def to_s
  	name
  end
end
