#encoding: utf-8
class PhongsController < ApplicationController
	def show
		@id = params[:id]
		@lichs = LichTrinhGiangDay.where(phong_moi: @id).order('ngay_day')
		respond_to do |format|
			format.html
		end
	end
end