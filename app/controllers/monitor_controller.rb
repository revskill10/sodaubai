require 'pg_tools'
class MonitorController < ActionController::Base
  include MonitorHelper
  include BuoihocHelper  
  before_filter :load_tenant
  before_filter :authenticate_user!  , :except => [:index, :show]
  before_filter :load_tuan
  before_filter :load_phongs

  def index
    @today = @days.select {|d| to_zdate(d["time"][0]) == Date.today }.sort_by {|k| to_zdatetime(k['time'][0])}
    respond_to do |format|
      format.html {render :index, :layout => 'application'}
    end
  end

  def show
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])
    @ngay = str_to_ngay(params[:id])
    @lich = @lop_mon_hoc.lich_trinh_giang_days.where(ngay_day: get_ngay(@ngay)).first    
    @trucnhat = JSON.parse(@lop_mon_hoc.trucnhat) if @lop_mon_hoc.trucnhat
    @nhomtruc = @trucnhat[from_zdate(params[:id])] if @trucnhat
    @svs = SinhVien.where(ma_sinh_vien: @nhomtruc) if @nhomtruc
    respond_to do |format|
      format.js
    end
  end
  def showdaybu
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])
    @ngay = str_to_ngay(params[:id])
    @lich = @lop_mon_hoc.lich_trinh_giang_days.where(ngay_day_moi: get_ngay(@ngay)).first    
    @trucnhat = JSON.parse(@lop_mon_hoc.trucnhat) if @lop_mon_hoc.trucnhat
    @nhomtruc = @trucnhat[from_zdate(params[:id])] if @trucnhat
    @svs = SinhVien.where(ma_sinh_vien: @nhomtruc) if @nhomtruc
    respond_to do |format|
      format.js
    end
  end
  def thanhtra
    authorize! :quanly, GiangVien
    dt = Date.today.to_datetime.change(:offset => Rational(7,24))
    @today = @days.select {|d| to_zdate(d["time"][0]) == Date.today }.select {|k| k['phong']}.sort_by {|k| k['phong']}
    @today += @days.select {|d| to_zdate(d["time"][0]) == Date.today }.select {|k| k['phong'].nil?}
    @lichs2 = LichTrucNhat.where("ngay_truc > timestamp ? and ngay_truc < timestamp ?", dt, DateTime.now).order('ngay_truc asc, created_at asc').map {|l| "#{l.lop_mon_hoc.ma_lop}_#{l.lop_mon_hoc.ma_mon_hoc}"}
    respond_to do |format|
      format.html {render :thanhtra, :layout => 'application'}
    end
  end
  def qlthanhtra
    authorize! :quanly, GiangVien
    @lenmuon = params[:lenmuon]
    @vesom = (params[:vesom] ? true: false)
    @bogio = (params[:bogio] ? true: false)
    @phong = params[:phong]
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])
    @ngay = str_to_ngay(params[:ngay_vi_pham])
    @lich_vi_pham = @lop_mon_hoc.lich_vi_phams.where(ngay_vi_pham: get_ngay(@ngay)).first_or_create!
    @lich_vi_pham.update_attributes(tuan: @current_week, user_id: current_user.id, phong: @phong, lenmuon: @lenmuon, vesom: @vesom, bogio: @bogio, note1: params[:note1])
    
    respond_to do |format|
      format.js
    end
  end
  def showthanhtra
    authorize! :quanly, GiangVien
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])
    @siso = @lop_mon_hoc.lop_mon_hoc_sinh_viens.count
    @ngay_vi_pham = params[:id]
    @phong = params[:phong]
    @ngay = str_to_ngay(@ngay_vi_pham)
    @lich = @lop_mon_hoc.lich_trinh_giang_days.where(ngay_day: get_ngay(@ngay)).first    
    @lich_vi_pham = @lop_mon_hoc.lich_vi_phams.where(ngay_vi_pham: get_ngay(@ngay)).first
    #if @lich_vi_pham
    #  @lich_vi_pham.upadte_attributes(tuan: @current_week, user_id: current_user.id, phong: @phong)
    @end        
    respond_to do |format|
      format.js
    end
  end
  def trucnhat
    authorize! :quanly, SinhVien
    dt = Date.today.to_datetime.change(:offset => Rational(7,24))
    @today = @days.select {|d| to_zdate(d["time"][0]) == Date.today }.select {|k| k['phong']}.sort_by {|k| k['phong']}
    @today += @days.select {|d| to_zdate(d["time"][0]) == Date.today }.select {|k| k['phong'].nil?}
    @lichs2 = LichTrucNhat.where("ngay_truc > timestamp ? and ngay_truc < timestamp ?", dt, DateTime.now).order('ngay_truc asc, created_at asc').map {|l| "#{l.lop_mon_hoc.ma_lop}_#{l.lop_mon_hoc.ma_mon_hoc}"}
    respond_to do |format|
      format.html {render :trucnhat, :layout => 'application'}
    end
  end  
  def qltrucnhat
    authorize! :quanly, SinhVien
    @svs = params[:msv]
    note = params[:note]
    phong = params[:phong]
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])
    @ngay = str_to_ngay(params[:ngay_truc])
    @lich = @lop_mon_hoc.lich_truc_nhats.where(ngay_truc: get_ngay(@ngay)).first_or_create!
    @lich.update_attributes(note: note, phong: phong, tuan: @current_week, user_id: current_user.id)
    if @lich.truc_nhats.count > 0
      @lich.truc_nhats.update_all(status: false)
    end
    if @svs and @svs.keys.count > 0
      @svs.keys.each do |sv|
        sv1 = @lich.truc_nhats.where(ma_sinh_vien: sv).first_or_create!
        sv1.update_attributes(status: true)
      end
    end
    respond_to do |format|
      format.js
    end
  end
  def showtrucnhat
    authorize! :quanly, SinhVien
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])
    @siso = @lop_mon_hoc.lop_mon_hoc_sinh_viens.count
    @ngay_truc = params[:id]
    @ngay = str_to_ngay(params[:id])
    @lich = @lop_mon_hoc.lich_trinh_giang_days.where(ngay_day: get_ngay(@ngay)).first    
    @lichtrucnhat = @lop_mon_hoc.lich_truc_nhats.where(ngay_truc: get_ngay(@ngay)).first
    @trucnhat = JSON.parse(@lop_mon_hoc.trucnhat) if @lop_mon_hoc.trucnhat
    @nhomtruc = @trucnhat[from_zdate(params[:id])] if @trucnhat
    @svs = SinhVien.where(ma_sinh_vien: @nhomtruc) if @nhomtruc
    if @lichtrucnhat
      @kotruc = @lichtrucnhat.truc_nhats.where(status: true).map {|t| t and t.ma_sinh_vien}
      @note = @lichtrucnhat.note
    end
    @phong = params[:phong]
    if @lich 
      @svvangs = @lich.diem_danhs.vang
    end
    respond_to do |format|
      format.js
    end
  end
  protected

  def load_tenant

    if @current_tenant ||= Tenant.last     
      PgTools.set_search_path @current_tenant.scheme    
     
    else
      PgTools.restore_default_search_path
     
    end
  end
  def load_tuan
    @week = current_tuan
    @current_week = @week.stt    
    @days = JSON.parse(@week.days)["ngay"]
  end
  def load_phongs
    
    dt = Date.today.to_datetime.change(:offset => Rational(7,24))
    tomorrow = dt + 1.day
    #@tiet = LichTrinhGiangDay.xac_dinh_gio(dt).change(:offset => Rational(7,24))
    @lichs = LichTrinhGiangDay.where("ngay_day > timestamp ? and ngay_day < timestamp ? and loai <> 2", dt, DateTime.now).order('ngay_day asc, created_at asc')
    @lichs2 = LichTrinhGiangDay.where("ngay_day > timestamp ? and ngay_day < timestamp ? and loai <> 2", dt, DateTime.now).order('ngay_day asc, created_at asc').map {|l| "#{l.lop_mon_hoc.ma_lop}_#{l.lop_mon_hoc.ma_mon_hoc}"}
    #@currents = LichTrinhGiangDay.current.map {|l| l and "#{l.lop_mon_hoc.ma_lop}_#{l.lop_mon_hoc.ma_mon_hoc}"}
    @lichdaybus = LichTrinhGiangDay.where("ngay_day_moi > timestamp ? and loai = 2 and status = 3 and ngay_day_moi < timestamp ?", dt, tomorrow).order('ngay_day_moi asc, created_at asc')
    #@res2 = @res.select {|n| to_zdate(n["time"][0]) == Date.today}
    #.map {|tkb| tkb and JSON.parse(tkb.days)["ngay"] }
    #.select {|n| to_zdate(n["time"][0]) == Date.today}

  end	
  
end