class QuanlyController < ApplicationController
	def index

		respond_to do |format|
			format.html
		end
	end
	def lopghep
		@lophcsv = SinhVien.all.uniq {|k| k.lop_hc }
		@loptinchi = LopMonHoc.all.uniq {|k| k.ma_lop }
		respond_to do |format|
			format.html
		end
	end
	def filterlophc
		lophc = params[:sv][:lophanhchinh]
		@svs = SinhVien.where(lop_hc: lophc)
		respond_to do |format|
			format.js
		end
	end
	def filterloptc
		loptc = params[:sv][:loptinchi]
		@svs = LopMonHocSinhVien.where(ma_lop_ghep: loptc)
		respond_to do |format|
			format.js
		end
	end
end
