class QuanlyController < ApplicationController
	def index
		authorize! :manage, LopMonHocSinhVien
		respond_to do |format|
			format.html
		end
	end
	def lopghep
		authorize! :manage, LopMonHocSinhVien
		@lophcsv = SinhVien.all.uniq {|k| k.lop_hc }
		@loptinchi = LopMonHoc.all.uniq {|k| k.to_s }
		respond_to do |format|
			format.html
		end
	end
	def movelopghep
		authorize! :manage, LopMonHocSinhVien
		if params[:msv]
			@svs = SinhVien.where(ma_sinh_vien: params[:msv].keys)
			@lop = LopMonHoc.find(params[:loptc])
			if @lop 
				@svs.each do |sv|
					@lop.lop_mon_hoc_sinh_viens.build(ma_sinh_vien: sv.ma_sinh_vien, ma_lop: @lop.ma_lop, ma_mon_hoc: @lop.ma_mon_hoc, loai: "1", ma_lop_hanh_chinh: sv.lop_hc, ten_mon_hoc: @lop.ten_mon_hoc, ho_dem: sv.dem, ho: sv.ho, ten: sv.ten)
					@lop.save!
				end
				@svs = @lop.lop_mon_hoc_sinh_viens
			end

		end
		respond_to do |format|
			format.js
		end
	end
	def checklopghep
		authorize! :manage, LopMonHocSinhVien
		@loptc = LopMonHoc.find(params[:loptc])
		@msvs = params[:msv].keys if params[:msv]
		if @loptc and @msvs
			@svs = @loptc.lop_mon_hoc_sinh_viens
			@dup = @svs.map(&:ma_sinh_vien) & @msvs
			@nondup = @msvs - @dup
			if @msvs.count > 0
				@sinhviens = SinhVien.where(ma_sinh_vien: @msvs)
				@dupcalendar = []
				if @sinhviens and @sinhviens.count > 0
					@sinhviens.each do |sv|
						if sv.check_conflict(@loptc)
							@dupcalendar << sv
						end
					end
				end
				@goodsv = @sinhviens - @dupcalendar
			end
		end
		respond_to do |format|
			format.js
		end
	end
	def updatelopghep
		authorize! :manage, LopMonHocSinhVien
		
		respond_to do |format|
			format.js
		end
	end
	def filterlophc
		authorize! :manage, LopMonHocSinhVien
		lophc = params[:sv][:lophanhchinh]
		@svs = SinhVien.where(lop_hc: lophc)
		respond_to do |format|
			format.js
		end
	end
	def filterloptc
		authorize! :manage, LopMonHocSinhVien
		@loptc = LopMonHoc.find(params[:sv][:loptinchi])
		if @loptc
			@svs = @loptc.lop_mon_hoc_sinh_viens
		end
		respond_to do |format|
			format.js
		end
	end
end
