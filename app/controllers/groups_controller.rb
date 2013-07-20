class GroupsController < ApplicationController
	before_filter :load_lop

	def create
		puts params[:sonhom]
		ti = params[:sonhom].to_i
		@lop_mon_hoc.groups.delete_all
		ti.times do |t|
			@lop_mon_hoc.groups.where(:name => "Group #{t}").first_or_create!
		end
		redirect_to lop_mon_hoc_lop_mon_hoc_sinh_viens_url(@lop_mon_hoc.id)
	end

	protected
	def load_lop
		@lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])
	end
end
