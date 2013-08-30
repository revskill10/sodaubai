class MonitorController < ActionController::Base

  before_filter :load_phongs

  def index

    respond_to do |format|
      format.html {render :index, :layout => 'application'}
    end
  end

  protected
  def load_phongs
    
    dt = Date.today.to_datetime.change(:offset => Rational(7,24))
    #@tiet = LichTrinhGiangDay.xac_dinh_gio(dt).change(:offset => Rational(7,24))
    @lichs = LichTrinhGiangDay.where("ngay_day > timestamp ? and ngay_day < timestamp ?", dt, DateTime.now).order('ngay_day asc')
  end	
end