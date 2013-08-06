# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    title "MyString"
    posts_count 1
    lop_mon_hoc_id 1
    user_id 1
    locked false
  end
end
