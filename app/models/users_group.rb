class UsersGroup < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, 
  #      :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :username, :password, :password_confirmation, :remember_me
  attr_accessible :group_id, :user_id

  belongs_to :user
  belongs_to :group
end
