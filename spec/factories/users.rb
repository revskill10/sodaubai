# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do  	
	  	username "dungth@hpu.edu.vn"
	  	code "dungth"  	
	factory :user_sv do 
		username "revskill09@gmail.com"
	  	code "123456"  	
	end
  end
end
