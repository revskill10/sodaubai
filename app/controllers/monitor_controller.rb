class MonitorController < ApplicationController
  before_filter :load_phongs

  def index

  end

  protected
  def load_phongs
    authorize! :monitor, LichTrinhGiangDay
    @tiet = LichTrinhGiangDay.xac_dinh_gio(DateTime.now).change(:offset => Rational(7,24))
    @lichs = LichTrinhGiangDay.where("updated_at > timestamp ?", @tiet)
  end	
end