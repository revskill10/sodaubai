class Tuan < ActiveRecord::Base
  attr_accessible :den_ngay, :stt, :tu_ngay
  default_scope order('stt')
  
  scope :current,  -> {
  	where("tu_ngay <= ?", Time.now.yesterday.yesterday.to_date)
  	.where("den_ngay >= ?", Time.now.yesterday.yesterday.to_date)  	
  }

  scope :with_date, lambda {|d| where("'#{d.utc}' between tu_ngay and den_ngay").first }
end
