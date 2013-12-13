class QuanlyController < ApplicationController
	include BuoihocHelper

	def index		
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "index", :label => "#{current_user.username}", :value => "1"}.to_json
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
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "lopghep", :label => "#{current_user.username}", :value => "1"}.to_json
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
					@lop.lop_mon_hoc_sinh_viens.build(ma_sinh_vien: sv.ma_sinh_vien, ma_lop: @lop.ma_lop, ma_mon_hoc: @lop.ma_mon_hoc, lop_ghep: true, tin_chi: sv.tin_chi?, ma_lop_hanh_chinh: sv.lop_hc, ten_mon_hoc: @lop.ten_mon_hoc, ho_dem: sv.dem, ho: sv.ho, ten: sv.ten, ma_lop_ghep: @lop.ma_lop, ngay_sinh: sv.ngay_sinh, creator: current_user.id)
					@lop.save!
				end
				@svs = @lop.lop_mon_hoc_sinh_viens
			end

		end    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "movelopghep", :label => "#{current_user.username}", :value => "1"}.to_json
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
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "checklopghep", :label => "#{current_user.username}", :value => "1"}.to_json
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
					@lop.lop_mon_hoc_sinh_viens.update_all({:status => true}, {:ma_sinh_vien => @msvs}, {:creator_id => current_user.id})
					@svs = @lop.lop_mon_hoc_sinh_viens
					@loptc = @lop.id
				end
			end
		rescue Exception => e 
			@error = e
		end    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "updatelopghep", :label => "#{current_user.username}", :value => "1"}.to_json
		respond_to do |format|
			format.js
		end
	end
	def filterlophc
		authorize! :manage, LopMonHocSinhVien
		lophc = params[:sv][:lophanhchinh]
		@svs = SinhVien.where(lop_hc: lophc)    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "filterlophc", :label => "#{current_user.username}", :value => "1"}.to_json
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
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "filterloptc", :label => "#{current_user.username}", :value => "1"}.to_json
		respond_to do |format|
			format.js
		end
	end
	def filtersv
		authorize! :manage, LopMonHocSinhVien
		@svs = SinhVien.where(ma_sinh_vien: params[:sv][:masinhvien])		
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "filtersv", :label => "#{current_user.username}", :value => "1"}.to_json
		respond_to do |format|
			format.js
		end
	end

	# quan ly nghi day
	def nghiday
		authorize! :manage, LichTrinhGiangDay

		@lichs = LichTrinhGiangDay.nghidaychoduyet
		@lichs2 = LichTrinhGiangDay.nghidayquakhu    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "nghiday", :label => "#{current_user.username}", :value => "1"}.to_json
		respond_to do |format|
			format.html
		end
	end
  def huynghiday
    @lichs3 = params[:lich]
    if @lichs3 and @lichs3.count > 0
      LichTrinhGiangDay.update_all({:status => nil, :loai => nil, :note => nil},{:id => @lichs3.keys})
    end    
    @lichs2 = LichTrinhGiangDay.nghidayquakhu    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "huynghiday", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|
      format.js
    end
  end
	def qlnghiday
		authorize! :manage, LichTrinhGiangDay

    dongy = params[:nghiday].select {|k,v| v == "true" }
    kodongy = params[:nghiday].select {|k,v| v == "false" }
    @dongys = LichTrinhGiangDay.where(id: dongy.keys)    
    @kodongys = LichTrinhGiangDay.where(id: kodongy.keys)

    if @dongys.count > 0      
      @dongys.update_all(:status => 3, :user_id => current_user.id)
    end
		if @kodongys.count > 0
      @kodongys.update_all(:status => 4, :user_id => current_user.id)
    end    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "qlnghiday", :label => "#{current_user.username}", :value => "1"}.to_json
		respond_to do |format|
			format.js
		end
	end
  # quan ly day bu
  def daybu
    #authorize! :manage, LichTrinhGiangDay

    @lichs = LichTrinhGiangDay.daybuchoduyet
    @lichs2 = LichTrinhGiangDay.daybuquakhu    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "daybu", :label => "#{current_user.username}", :value => "1"}.to_json
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
            lich.nguoi_duyet = current_user
            lich.tuan = lich.get_tuan
            lich.save!
          end
        elsif qd == "false"
          if lich 
            lich.status = 4
            lich.nguoi_duyet = current_user
            lich.tuan = lich.get_tuan
            lich.save!
          end
        end

      end
    end    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "qldaybu", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|
      format.js
    end
  end

  def phongtrong  	
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "phongtrong", :label => "#{current_user.username}", :value => "1"}.to_json
  	respond_to do |format|
  		format.html
  	end
  end
  def getphongtrong
  	@ngay = str_to_date(params[:ngay])  	
  	@phongtrong = LichTrinhGiangDay.phong_trong(@ngay)    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "getphongtrong", :label => "#{current_user.username}", :value => "1"}.to_json
  	respond_to do |format|
  		format.js  		
  	end
  end

  # nghi day hang loat
  def nghidayhangloat
  	if params[:ngay]
  	  @ngay = str_to_date(params[:ngay])  	
  	  @today = LichTrinhGiangDay.lich_day_phan_bo(@ngay)      
      QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "nghidayhangloat", :label => "#{current_user.username}", :value => "1"}.to_json
  	  respond_to do |format|
  		  format.js
  	  end
  	else
      QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "nghidayhangloat", :label => "#{current_user.username}", :value => "1"}.to_json
      respond_to do |format|
        format.html
      end
  	end  	
  end
  def post_nghidayhangloat
  	@lichs = params[:lich]
    if @lichs
      @lichs.each do |k,v|
        lop = LopMonHoc.find(k)
        if lop
          d = v.keys[0].split(",").to_a               
          ngay_day = DateTime.strptime(d[0].gsub("T","-").gsub("Z",""), "%Y-%m-%d-%H:%M").change(:offset => Rational(7,24))
          nd=Time.zone.parse(ngay_day.to_s)
          sotiet = d[1].to_i
          phong = d[2]
          tuan = d[3].to_i
          @lich = lop.lich_trinh_giang_days.where(ngay_day: nd).first
          if @lich 
            @lich.loai = 1 unless @lich.loai == 2
            @lich.status = 3                  
            @lich.nghile = true      
            @lich.nguoi_duyet = current_user
            @lich.save!
          else
            @lich = lop.lich_trinh_giang_days.create!(ngay_day: nd, phong_moi: phong, so_tiet_day: sotiet, tuan: tuan, siso: lop.siso)
            if @lich
              @lich.loai = 1
              @lich.status = 3                   
              @lich.nghile = true       
              @lich.nguoi_duyet = current_user
              @lich.save!
            end
          end
        end

      end
    end    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "post_nghidayhangloat", :label => "#{current_user.username}", :value => "1"}.to_json
  	respond_to do |format|
  		format.js
  	end
  end

  def vipham
    @lichs = LichViPham.order('ngay_vi_pham, tuan')    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "vipham", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|
      format.html
    end
  end
  
  def qlvipham
    @tuan = params[:tuan]
    if params[:vipham]
      @viphams = LichViPham.find(params[:vipham].keys)
      @viphams.each do |vp|
        vp.lenmuon = (params[:vipham][vp.id.to_s][:lenmuon] != "false" ? true : false)
        vp.vesom = (params[:vipham][vp.id.to_s][:vesom] != "false" ? true: false)
        vp.bogio = (params[:vipham][vp.id.to_s][:bogio] != "false" ? true: false)
        vp.note1 = params[:vipham][vp.id.to_s][:note1]
        vp.note2 = params[:vipham][vp.id.to_s][:note2]
        vp.nguoi_duyet = current_user
        vp.save!
      end
    end
    if @tuan 
      @lichs = LichViPham.where(tuan: @tuan).order('ngay_vi_pham, tuan')
    else
      @lichs = LichViPham.order('ngay_vi_pham, tuan')
    end        
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "qlvipham", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|
      format.js
      format.html { render 'vipham' }
    end
  end

  def dkbs
    #authorize! :manage, LichTrinhGiangDay

    @lichs = LichTrinhGiangDay.dkbschoduyet
    @lichs2 = LichTrinhGiangDay.dkbsquakhu    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "dkbs", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|
      format.html
    end
  end
  def qldkbs
    authorize! :manage, LichTrinhGiangDay
    dkbss = params[:dkbs]
    
    if dkbss and dkbss.keys.count > 0
      @lichs = LichTrinhGiangDay.where(id: dkbss.keys)
      dkbss.each do |k,v|
        phong = v[:phong]
        qd = v[:qd]
        lich = @lichs.select {|l| l.id == k.to_i }.first
        if qd == "true"          
          if lich 
            lich.status = 3
            lich.phong = phong
            lich.nguoi_duyet = current_user
            lich.tuan = lich.get_tuan
            lich.save!
          end
        elsif qd == "false"
          if lich 
            lich.status = 4
            lich.nguoi_duyet = current_user
            lich.tuan = lich.get_tuan
            lich.save!
          end
        end

      end
    end
    @lichs = LichTrinhGiangDay.dkbschoduyet
    @lichs2 = LichTrinhGiangDay.dkbsquakhu    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "qldkbs", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|
      format.js
    end
  end
  # Danh sach giang vien dang ky nghi day
  def report1  	    
    authorize! :thongke, SinhVien
    sql = "SELECT l1.id, l1.ma_giang_vien,l1.ten_giang_vien,l1.ma_lop,l1.ten_mon_hoc,l.phong_moi,l.tuan,l.ngay_day,l.so_tiet_day,Case when l.status=3 then 'Duyet' when l.status=6 then 'Chua duyet' when l.status=4 then 'Khong duyet' END  as TrangThai  FROM t1.lich_trinh_giang_days l inner join t1.lop_mon_hocs l1 on l.lop_mon_hoc_id=l1.id where l.loai=1 and l.tuan=4 Order by l.ngay_day"
    #@res = LichTrinhGiangDay.paginate_by_sql(sql, :page => params[:page] || 1, :per_page => 50)
    @res = ActiveRecord::Base.connection.execute(sql)    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "report1", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|
      format.html
    end
  end

  # Danh sach sinh vien vang theo tuan
  def report2
    authorize! :thongke, SinhVien  	
  	@tuan = params[:tuan] || @current_week  	
  	sql = "Select l1.id, l1.ma_giang_vien, d.ma_sinh_vien,s.ho,s.ho_dem,s.ten,l1.ma_lop,l1.ma_mon_hoc,l1.ten_mon_hoc,l1.ten_giang_vien,d.so_tiet_vang,l.ngay_day from t1.diem_danhs d inner join t1.lich_trinh_giang_days l on d.lich_trinh_giang_day_id=l.id inner join t1.lop_mon_hocs l1 on l.lop_mon_hoc_id=l1.id inner join t1.sinh_viens s on d.ma_sinh_vien=s.ma_sinh_vien Where d.lich_trinh_giang_day_id in (Select id From t1.Lich_trinh_giang_days where tuan= #{@tuan} ) and d.so_tiet_vang>0 and l.destroyed_at is null Order by l.ngay_day,l1.ma_lop,d.ma_sinh_vien"
  	#@res = DiemDanh.paginate_by_sql(sql, :page => params[:page] || 1, :per_page => 50)
    @res = ActiveRecord::Base.connection.execute(sql)
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "report2", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|
      format.html
    end
  end

  # Danh sach sinh vien nghi qua 20% so tiet
  def report3  	
    authorize! :thongke, SinhVien
  	sql = <<-eos
		select *,ROUND(TongSoTietVang/so_tiet_phan_bo*100,2) as Tile
From (
Select l1.ma_giang_vien, l1.id, d.ma_sinh_vien,s.ho,s.ho_dem,s.ten,s.lop_hc,l1.ma_lop,l1.id Lop_mon_hoc_id,l1.ma_mon_hoc,l1.ten_mon_hoc,l1.ten_giang_vien,l1.so_tiet_phan_bo,sum(d.so_tiet_vang) As TongSoTietVang
from t1.diem_danhs d
inner join t1.lich_trinh_giang_days l on d.lich_trinh_giang_day_id=l.id
inner join t1.lop_mon_hocs l1 on l.lop_mon_hoc_id=l1.id
inner join t1.sinh_viens s on d.ma_sinh_vien=s.ma_sinh_vien
where l1.so_tiet_phan_bo>0
and l.destroyed_at is null
Group by d.ma_sinh_vien,s.ho,s.ho_dem,s.ten,s.lop_hc,l1.ma_lop,l1.id,l1.ma_mon_hoc,l1.ten_mon_hoc,l1.ten_giang_vien,l1.so_tiet
having sum(d.so_tiet_vang)>0
) as S
Where TongSoTietVang/so_tiet_phan_bo*100>=20
Order by Tile DESC
  	eos
  	#@res = DiemDanh.paginate_by_sql(sql,  :page => params[:page] || 1, :per_page => 50)
  	@res = ActiveRecord::Base.connection.execute(sql)    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "report3", :label => "#{current_user.username}", :value => "1"}.to_json
  	respond_to do |format|
  		format.html
  	end
  end
  # Danh sach sinh vien lop mon nghi nhieu trong tuan
  def report4
    authorize! :thongke, SinhVien
  	@tuan = params[:tuan] || @current_week  	
  	sql = <<-eos
		Select l1.id, l1.ma_giang_vien, d.ma_sinh_vien,s.ho,s.ho_dem,s.ten,l1.ma_lop,l1.id Lop_mon_hoc_id,l1.ma_mon_hoc,l1.ten_mon_hoc,l1.ten_giang_vien,SUM(d.so_tiet_vang) AS TongTietVang
from t1.diem_danhs d
inner join t1.lich_trinh_giang_days l on d.lich_trinh_giang_day_id=l.id
inner join t1.lop_mon_hocs l1 on l.lop_mon_hoc_id=l1.id
inner join t1.sinh_viens s on d.ma_sinh_vien=s.ma_sinh_vien
Where d.lich_trinh_giang_day_id in (Select id
From t1.Lich_trinh_giang_days
where tuan=#{@tuan}
) and d.so_tiet_vang>0
Group by d.ma_sinh_vien,s.ho,s.ho_dem,s.ten,l1.ma_lop,l1.id ,l1.ma_mon_hoc,l1.ten_mon_hoc,l1.ten_giang_vien
Having SUM(d.so_tiet_vang)>=6
ORDER BY SUM(d.so_tiet_vang) DESC	
  	eos
  	#@res = DiemDanh.paginate_by_sql(sql,  :page => params[:page] || 1, :per_page => 50)
  	
  	@res = ActiveRecord::Base.connection.execute(sql)    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "report4", :label => "#{current_user.username}", :value => "1"}.to_json
  	respond_to do |format|
  		format.html
  	end
  end

  # Giang Vien Chua Tham Gia Ghi Lich Trinh Theo Tuan 
  def report5
    authorize! :thongke, SinhVien
  	@tuan = params[:tuan] || @current_week
  	sql = <<-eos
		Select ma_giang_vien,ten_giang_vien,ma_lop,ma_mon_hoc,ten_mon_hoc,phong,lop_mon_hoc_id
From t1.tkb_giang_viens 
where tuan_hoc_bat_dau + So_tuan > #{@tuan} and tuan_hoc_bat_dau<= #{@tuan} and lop_mon_hoc_id not in (Select l1.id
from t1.lich_trinh_giang_days l
inner join t1.lop_mon_hocs l1 on l.lop_mon_hoc_id=l1.id
Where l.tuan= #{@tuan} and date_trunc('day', l.ngay_day)>'2013-09-02 00:00:00') and ma_giang_vien not in ('02050014','02050015','03020006','07050004','1971021017','1971021018','1971021019','1971021020','1971021023','1971021024','99020002')
Order by ma_giang_vien
  	eos
  	#@res = LichTrinhGiangDay.paginate_by_sql(sql, :page => params[:page] || 1, :per_page => 50)
  	
  	@res = ActiveRecord::Base.connection.execute(sql)    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Quanly", :action => "report5", :label => "#{current_user.username}", :value => "1"}.to_json
  	respond_to do |format|
  		format.html
  	end
  end
  protected
  def to_zdate(str)
    DateTime.strptime(str.gsub("T","-").gsub("Z",""), "%Y-%m-%d-%H:%M").change(:offset => Rational(7,24))
  end
  def from_zdate(str)
    str1 = str.split("-").to_a
     str2 = str1[0]+"-"+str1[1]+"-"+str1[2]+"T"+str1[3]+":"+str1[4]+":00Z"
     return str2
  end
end
