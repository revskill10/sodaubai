class QuanlyController < ApplicationController
	def index
		authorize! :manage, LopMonHocSinhVien
		respond_to do |format|
			format.html
		end
	end
	def lopghep
		authorize! :manage, LopMonHocSinhVien
		@allsv = SinhVien.all
		@lophcsv = @allsv.uniq {|k| k.lop_hc }
		@loptinchi = LopMonHoc.all.uniq {|k| k.to_s }
		@msvs = @allsv.uniq {|k| k.ma_sinh_vien}
		respond_to do |format|
			format.html
		end
	end
	def movelopghep
		authorize! :manage, LopMonHocSinhVien
		if params[:msv]
			@svs = SinhVien.where(ma_sinh_vien: params[:msv].keys)
			@lop = LopMonHoc.find(params[:loptc])			
			@svs1 = @svs.map {|k1| k1.ma_sinh_vien}

			if @lop 
				@msvs = @lop.lop_mon_hoc_sinh_viens.map {|t| t.ma_sinh_vien}
				@goodsv = @svs.select {|m| !@msvs.include?(m.ma_sinh_vien);}
				@goodsv.each do |sv|
					@lop.lop_mon_hoc_sinh_viens.build(ma_sinh_vien: sv.ma_sinh_vien, ma_lop: @lop.ma_lop, ma_mon_hoc: @lop.ma_mon_hoc, lop_ghep: true, tin_chi: sv.tin_chi?, ma_lop_hanh_chinh: sv.lop_hc, ten_mon_hoc: @lop.ten_mon_hoc, ho_dem: sv.dem, ho: sv.ho, ten: sv.ten, ma_lop_ghep: @lop.ma_lop)
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
			@dupsv = SinhVien.where(ma_sinh_vien: @dup)
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
				@goodsv = @sinhviens - @dupcalendar - @dupsv
			end
		end
		respond_to do |format|
			format.js
		end
	end
	def updatelopghep
		authorize! :manage, LopMonHocSinhVien
		begin
			if params[:msv]
				@msvs = params[:msv].keys
				@lop = LopMonHoc.find(params[:loptc])
				if @lop
					@lop.lop_mon_hoc_sinh_viens.update_all({:status => true}, {:ma_sinh_vien => @msvs})
					@svs = @lop.lop_mon_hoc_sinh_viens
					@loptc = @lop.id
				end
			end
		rescue Exception => e 
			@error = e
		end
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
	def filtersv
		authorize! :manage, LopMonHocSinhVien
		@svs = SinhVien.where(ma_sinh_vien: params[:sv][:masinhvien])
		
		respond_to do |format|
			format.js
		end
	end

	# quan ly nghi day
	def nghiday
		authorize! :manage, LichTrinhGiangDay

		@lichs = LichTrinhGiangDay.nghidaychoduyet
		@lichs2 = LichTrinhGiangDay.nghidayquakhu
		respond_to do |format|
			format.html
		end
	end
	def qlnghiday
		authorize! :manage, LichTrinhGiangDay

    dongy = params[:nghiday].select {|k,v| v == "true" }
    kodongy = params[:nghiday].select {|k,v| v == "false" }
    @dongys = LichTrinhGiangDay.where(id: dongy.keys)    
    @kodongys = LichTrinhGiangDay.where(id: kodongy.keys)

    if @dongys.count > 0      
      @dongys.update_all("status = 3")
    end
		if @kodongys.count > 0
      @kodongys.update_all("status = 4")
    end
		respond_to do |format|
			format.js
		end
	end
  # quan ly day bu
  def daybu
    authorize! :manage, LichTrinhGiangDay

    @lichs = LichTrinhGiangDay.daybuchoduyet

    respond_to do |format|
      format.html
    end
  end
  def qldaybu
    authorize! :manage, LichTrinhGiangDay
    daybus = params[:daybu]

    if daybus and daybus.keys.count > 0
      @lichs = LichTrinhGiangDay.where(id: daybus.keys)
      daybus.each do |k,v|
        phong = v[:phong]
        qd = v[:qd]
        lich = @lichs.select {|l| l.id == k.to_i }.first
        if qd == "true"          
          if lich 
            lich.status = 3
            lich.phong_moi = phong
            lich.save!
          end
        else
          if lich 
            lich.status = 4
            lich.save!
          end
        end

      end
    end
    
    respond_to do |format|
      format.js
    end
  end
end
