class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  attr_accessible :username, :code, :role
  devise :cas_authenticatable

  def cas_extra_attributes=(extra_attributes)
    if extra_attributes["status"] == 0
    	self.role = "guest"
    else
    	if extra_attributes["role"] == 1
    		self.role = "student"
    		self.code = extra_attributes["masinhvien"]
    	elsif extra_attributes["role"] == 2
    		self.role = "teacher"
    		self.code = extra_attributes["masinhvien"]
    	elsif extra_attributes["role"]== 0
    		self.role = "guest"
    	end
    			
    end
  end
end
