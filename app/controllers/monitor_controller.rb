require 'pg_tools'
class MonitorController < ActionController::Base
  include MonitorHelper
  include BuoihocHelper
  before_filter :load_tenant
  before_filter :load_tuan
  before_filter :load_phongs

  def index

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
    #@tiet = LichTrinhGiangDay.xac_dinh_gio(dt).change(:offset => Rational(7,24))
    @lichs = LichTrinhGiangDay.where("ngay_day > timestamp ? and ngay_day < timestamp ?", dt, DateTime.now).order('ngay_day asc, created_at asc')
    @lichs2 = LichTrinhGiangDay.where("ngay_day > timestamp ? and ngay_day < timestamp ?", dt, DateTime.now).order('ngay_day asc, created_at asc').map {|l| "#{l.lop_mon_hoc.ma_lop}_#{l.lop_mon_hoc.ma_mon_hoc}"}
    @currents = LichTrinhGiangDay.current.map {|l| l and "#{l.lop_mon_hoc.ma_lop}_#{l.lop_mon_hoc.ma_mon_hoc}"}
    @today = @days.select {|d| to_zdate(d["time"][0]) == Date.today }.sort_by {|k| to_zdatetime(k['time'][0])}
    #@res2 = @res.select {|n| to_zdate(n["time"][0]) == Date.today}
    #.map {|tkb| tkb and JSON.parse(tkb.days)["ngay"] }
    #.select {|n| to_zdate(n["time"][0]) == Date.today}

  end	
  
end