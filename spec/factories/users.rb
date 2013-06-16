# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do  	|u|
	  	u.username "dungth@hpu.edu.vn"
	  	u.code "dungth"  	
	factory :user_sv do |us|
		us.username "revskill09@gmail.com"
	  	us.code "123456"  		
	end	
	u.association :imageable, :factory => :giang_vien
  end
end
