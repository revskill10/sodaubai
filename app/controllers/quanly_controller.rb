class QuanlyController < ApplicationController
	def index

		respond_to do |format|
			format.html
		end
	end
	def loptach
		@lophcsv = SinhVien.all.uniq {|k| k.lop_hc }
		@loptinchi = LopMonHoc.all.uniq {|k| k.ma_lop }
		respond_to do |format|
			format.html
		end
	end
	def update_loptach
		respond_to do |format|
			format.js
		end
	end
end
