class LopMonHocsController < ApplicationController
  include DashboardHelper
  
  before_filter :authenticate_user!
  before_filter :load_lop, :except => :index


  # GET /lop_mon_hocs/1
  # GET /lop_mon_hocs/1.json
  def index

    @lops = LopMonHoc.find(:all, :order => "id desc", :limit => 3)
    respond_to do |format|    
      format.xlsx {
        p = Axlsx::Package.new        
        wb = p.workbook
        wb.add_worksheet(:name => "Pie Chart") do |sheet|
          sheet.add_row ["Simple Pie Chart"]
          @lops.each { |label| sheet.add_row [label.ma_lop, label.get_sinh_viens.count] }
          sheet.add_chart(Axlsx::Pie3DChart, :start_at => [0,5], :end_at => [10, 20], :title => "example 3: Pie Chart") do |chart|
            chart.add_series :data => sheet["B2:B4"], :labels => sheet["A2:A4"],  :colors => ['FF0000', '00FF00', '0000FF']
          end
        end
        send_data p.to_stream.read, :filename => 'lops.xlsx', :type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet"     
      }
    end  
        
  end
  
  def show
    authorize! :read, @lop_mon_hoc
    @svs = @lop_mon_hoc.get_sinh_viens
    @diem_chuyen_cans = @lop_mon_hoc.diem_chuyen_cans
    @dccs = {}
    @dccs2 = {}
    @diem_chuyen_cans.each do |dcc|
     @dccs[dcc.ma_sinh_vien] = dcc.tong_so_tiet_vang || 0
     @dccs2[dcc.ma_sinh_vien] = dcc.so_tiet || 1
    end
    respond_to do |format|
      if request.headers['X-PJAX']
        format.html {render :layout => false}        
      else
        format.html {render :show}
       # format.xlsx {render xlsx: :dslop, filename: "dslop_doc"}
      end
    end
  end
  def update
    sn = params[:so_nhom].blank? ? 1 : params[:so_nhom]
    @lop_mon_hoc.update_attributes(group: sn)

    if @lop_mon_hoc.save! then 
      respond_to do |format|
        format.js
      end
    end
  end
  def calendar
    @lich = @lop_mon_hoc.get_days
    respond_to do |format|
      if request.headers['X-PJAX']
        format.html {render :calendar, :layout => false}        
      else        
        format.html {render :calendar}        
      end

    end
  end
 
  protected
  def load_lop
    @lop_mon_hoc ||= LopMonHoc.find(params[:id])

  end
end
