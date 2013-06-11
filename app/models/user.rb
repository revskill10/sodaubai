class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  attr_accessible :username, :code
  devise :cas_authenticatable

  def cas_extra_attributes=(extra_attributes)
    if extra_attributes["status"] == 0
    	self.add_role :guest
    else    	    		
        self.add_role :normal
    		self.code = extra_attributes["masinhvien"]    	    		
    end
  end
end
