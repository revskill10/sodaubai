class MonitorController < ApplicationController
  before_filter :load_phongs

  def index

  end

  protected
  def load_phongs
    authorize! :monitor, LichTrinhGiangDay
    dt = DateTime.now
    @tiet = LichTrinhGiangDay.xac_dinh_gio(dt.prev_day).change(:offset => Rational(7,24))
    @lichs = LichTrinhGiangDay.where("updated_at > timestamp ?", @tiet)
  end	
end