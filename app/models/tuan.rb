class Tuan < ActiveRecord::Base
  attr_accessible :den_ngay, :stt, :tu_ngay

  scope :current, lambda {where("'#{Time.now}' between tu_ngay and den_ngay") }

  scope :with_date, lambda {|d| where("'#{d}' between tu_ngay and den_ngay")}
end
