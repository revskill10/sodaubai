# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    body "MyText"
    lop_mon_hoc_id 1
    topic_id 1
    user_id 1
  end
end
