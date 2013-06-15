class LopMonHocsController < ApplicationController
  
  before_filter :authenticate_user!
  helper_method :is_today?, :is_current?
  # GET /lop_mon_hocs/1
  # GET /lop_mon_hocs/1.json
  def show
    @lop_mon_hoc = LopMonHoc.find(params[:id])
    @tkbs = @lop_mon_hoc.tkb_giang_viens
    authorize! :read, @lop_mon_hoc
    @lichs = @tkbs.map {|l|  l.schedule.all_occurrences }
    m = @lichs.max {|a,b| a.count <=> b.count}
    @lichs.select { |l| l.count < m.count}.each do |nl|
      (nl.count .. m.count-1).each do |i|
        nl[i] = nil
      end
    end
    

    @lichs2 = @lichs.transpose
    @current_day = get_next_day(@lichs2)
    @tuan_bat_dau = @tkbs[0].tuan_hoc_bat_dau
    @tuan_ket_thuc = @tuan_bat_dau + @tkbs[0].so_tuan
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lop_mon_hoc }
    end
  end
  
  
  def is_today?(option)
      begin_day = option[0].beginning_of_week       
      return begin_day === Date.today.beginning_of_week
  end
  def get_next_day(lich)
    a = []
    lich.each do |l|      
      a.concat(l)
    end
    days = a.select {|x| x and Date.today <= x.to_date}    
    return nil if days.empty?
    return days.first.to_date
  end
end
