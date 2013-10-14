# encoding: UTF-8
class LopMonHocsController < ApplicationController  
  
  include DashboardHelper
  include LopMonHocsHelper  
  before_filter :authenticate_user!
  before_filter :load_lop, :except => :index
  
  def tinhhinh
    authorize! :manage, @lop_mon_hoc

    respond_to do |format|
      format.pdf do 

      end
    end
  end
  def lichtrinh
    authorize! :manage, @lop_mon_hoc    
    #output = LichReport.new(@lop_mon_hoc).to_pdf    
    @lichs = @lop_mon_hoc.lich_trinh_giang_days.where('char_length(noi_dung_day) > 0').order('ngay_day, tuan')
    respond_to do |format|
      format.pdf do
        pdf = Prawn::Document.new(:page_layout => :portrait,         
        :page_size => 'A4')
        pdf.font "#{Rails.root}/app/assets/fonts/arial.ttf"
        
        items = @lichs.map do |item|
          [
            item.tuan,            
            item.noi_dung_day,
            item.so_tiet_day_moi,
            item.hienthingay                    
          ]
        end        
        items.unshift ["Tuần","NỘI DUNG GIẢNG DẠY","Số tiết","Thứ ngày thực hiện"]
        cell_width = 50
        row_height = 120
        img_path = "#{Rails.root}/public/images/logo.png"
        pieces = [[img_path, ""]]
        pieces.each do |p|
          #pdf.move_down 5 # a bit of padding
          cursor = pdf.cursor 
          p.each_with_index do |v,j|
             pdf.bounding_box [cell_width*j, cursor], :height => row_height, :width => ( j == 0 ? cell_width : 600) do
              if j == 0
                pdf.image v, :width => 40
              else
                #pdf.text v, :size => 10 unless v.blank?
                dd = [["BỘ GIÁO DỤC VÀ ĐÀO TẠO","","CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM"],["TRƯỜNG ĐẠI HỌC DÂN LẬP HẢI PHÒNG","","Độc lập - Tự do - Hạnh phúc"]]
                pdf.table dd, :cell_style => {:borders => [], size: 12}, :column_widths => {1 => 50}  do
                  
                  dd.count.times do |t|
                    [0,1,2].each do |k|
                      row(t).columns(k).valign = :center                      
                      row(t).columns(k).align = :center                                 
                    end                  
                  end                                    
                  row(0).columns(1).size = 12
                  row(1).columns(1).size = 13
                end
              end
            end
          end
        end
        # header
        pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], :width  => pdf.bounds.width do               
            pdf.move_down(80)
            pdf.text "LỊCH GIẢNG DẠY", :align => :center, :size => 16
            pdf.move_down(30)
            data = [
              ["Số tuần lễ", "","#{@lop_mon_hoc.sotuan}","", "Môn học: #{@lop_mon_hoc.ten_mon_hoc}"],
              ["Số tiết lý thuyết", "","...","", "CBGD phục trách: #{@lop_mon_hoc.ten_giang_vien}"],
              ["Số tiết BT,TN,TH,TKMH ","","...","", "Ngành: ........... Khóa: .........."],
              ["Tổng số tiết","","#{@lop_mon_hoc.khoi_luong}","", "Lớp: #{@lop_mon_hoc.ma_lop} Học kỳ: #{@current_tenant.hoc_ky} Năm học: #{@current_tenant.nam_hoc}"]
            ]
            pdf.table data, :cell_style => {:borders => [], :size => 13}, :column_widths => {0 => 200, 2 => 30, 3 => 30} do               
              4.times do |t|
                row(t).columns(2).align = :center
              end
              row(0).columns(0).borders = [:top, :left]
              row(0).columns(1).borders = [:top]
              row(0).columns(2).borders = [:top, :right]
              row(0).columns(3).size = 13

              row(1).columns(0).borders = [:left]
              row(1).columns(1).borders = []
              row(1).columns(2).borders = [:right]
              row(1).columns(3).size = 13

              row(2).columns(0).borders = [:left]
              row(2).columns(1).borders = []
              row(2).columns(2).borders = [:right]
              row(2).columns(3).size = 13

              row(3).columns(0).borders = [:left, :bottom]
              row(3).columns(1).borders = [:bottom]
              row(3).columns(2).borders = [:right, :bottom]
              row(3).columns(3).size = 13
              #row(0).columns(0).font_style = :bold

            end

        end
        pdf.move_down(20)
        
        pdf.table(items, :header => true, :cell_style => {:size => 14}, :column_widths => {0 => 60,1 => 200, 2 => 60, 3 => 200}, :width => 520) do           
          items.count.times do |t|
            [0,1,2,3].each do |k|
              row(t).columns(k).valign = :center
              row(t).columns(k).align = :center
            end
          end
          row(0).columns(2).valign = :center
          row(0).columns(2).align = :center          
        end
        pdf.move_down(20)        
        pdf.text "Ghi chú: Lập thành 02 bản - Bộ môn và CBGD thực hiện - Kết thúc học kỳ nộp lại cho phòng ĐT"
        d = DateTime.now
        footer = [["","", "Hải phòng, ngày #{d.day} tháng #{d.month} năm #{d.year}"],
        ["CHỦ NHIỆM BỘ MÔN","","GIẢNG VIÊN"]]
        pdf.table footer, :cell_style => {:borders => []}, :column_widths => {0 => 200, 1 => 100}, :width => 520 do 
          row(0).columns(2).align = :center
          row(1).columns(0).align = :center
          row(1).columns(2).align = :center
        end
        pdf.move_down(20)
        pdf.text "KÝ DUYỆT KẾ HOẠCH"
        pdf.move_down(60)
        pdf.text "KÝ XÁC NHẬN ĐÃ HOÀN THÀNH KẾ HOẠCH"        
        pdf.create_stamp("approved") do
          pdf.rotate(30, :origin => [-5, -5]) do
            pdf.stroke_color "FF3333"
            pdf.stroke_ellipse [0, 0], 29, 15
            pdf.stroke_color "000000"
          
            pdf.fill_color "993333"
            
            pdf.draw_text "Đã xác nhận", :at => [-23, -3]            
            pdf.fill_color "000000"
          end
        end              
        pdf.repeat(:all) do 
          pdf.draw_text "QC07-B04/1", :at => [10, -10]
          pdf.stamp "approved" 
        end
        pdf.number_pages "Trang <page>", :at => [400, -10], :page_filter => :all
        send_data pdf.render, filename: "lich_trinh_lop_#{@lop_mon_hoc.ma_lop}_#{@lop_mon_hoc.ten_giang_vien}.pdf", 
                          type: "application/pdf"
      end
    end
  end  
  def index
    authorize! :read, @lop_mon_hoc
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
  def report

    raise ActiveRecord::RecordNotFound unless @lop_mon_hoc
    #@lichs = @lop_mon_hoc.lich_trinh_giang_days.order('ngay_day, tuan')
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    respond_to do |format|
      format.html
    end

  end
  def show
    authorize! :read, @lop_mon_hoc
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    
    @lichs = @lop_mon_hoc.lich_trinh_giang_days.where('char_length(noi_dung_day) > 0').order('ngay_day, tuan')
    respond_to do |format|      
      format.html {render :show}
      #format.pdf { render_lichtrinh(@lichs) }
    end    
  end
  def export_lichtrinh
    authorize! :manage, @lop_mon_hoc
    @lichs = @lop_mon_hoc.lich_trinh_giang_days.where('char_length(noi_dung_day) > 0').order('ngay_day, tuan')
    @sotuan = @lichs.pluck(:tuan).uniq.count
    respond_to do |format|
      format.html
    end
  end
  def tuan
    @lop_mon_hoc = LopMonHoc.find(params[:id])
    @lichlop = @lop_mon_hoc.get_days
    @lich = @lichlop.select {|l| l["tuan"] == params[:tuan_id].to_i}.uniq if @lichlop
    respond_to do |format|
      format.html { render 'calendar'}
    end
  end
  def update
    authorize! :manage, @lop_mon_hoc
    @sn = params[:so_nhom].to_s.empty? ? 1 : params[:so_nhom].to_i
    @sl = params[:so_lan_kt].to_s.empty? ? 0 : params[:so_lan_kt].to_i
    @st = params[:so_tiet_phan_bo].empty? ? @lop_mon_hoc.so_tiet : params[:so_tiet_phan_bo].to_f
    th = params[:thuc_hanh]
    if @sn <= 0 then @sn = 1 end
    @lop_mon_hoc.update_attributes(group: @sn, so_lan_kt: @sl, so_tiet_phan_bo: @st) if @sl >= 0 and @sl <= 5 and @sn >= 1 
    @lop_mon_hoc.thuc_hanh = true if th
    @lop_mon_hoc.thuc_hanh = false unless th
    

    if @lop_mon_hoc.save! then 
      @lop_mon_hoc_sinh_viens = @lop_mon_hoc.lop_mon_hoc_sinh_viens
      @lop_mon_hoc_sinh_viens.update_all(:group_id => 1) if @sn == 1 
      @group = @lop_mon_hoc.group || 1
      @groups_arrays = {}
      @group.times do |g|
        @groups_arrays[(g+1).to_s] = "Nhóm #{g+1}"
      end
      respond_to do |format|
        format.js
      end
    end
  end


  def search
    authorize! :search, LopMonHoc

    @lop = LopMonHoc.find(params[:id])    
    @lichtrucnhat = @lop.convert_trucnhat if @lop.trucnhat
    respond_to do |format|
      format.js
      format.xlsx {
        p = Axlsx::Package.new
        wb = p.workbook
        wb.add_worksheet(:name => "Lịch trực nhật") do |sheet|
          sheet.add_row ["Lịch trực nhật"]
          sheet.add_row ["Mã lớp: #{@lop.ma_lop}"]
          sheet.add_row ["Tên môn học: #{@lop.ten_mon_hoc}"]
          sheet.add_row ["Tên giảng viên: #{@lop.ten_giang_vien}"]
          sheet.add_row ["Phòng: #{@lop.phong_hoc}"]
          sheet.add_row ["Ngày bắt đầu: #{@lop.ngay_bat_dau.localtime.strftime('%d/%m/%Y %Hh:%M')}"]
          sheet.add_row ["Ngày kết thúc: #{@lop.ngay_ket_thuc.localtime.strftime('%d/%m/%Y %Hh:%M')}"]
          sheet.add_row ["Ca học", "Thời gian", "Họ và tên", "Mã sinh viên", "Mã lớp hành chính", "Hoàn thành", "Không hoàn thành"]
          @lichtrucnhat.each { |label| sheet.add_row [label[:ca], label[:time], label[:ho_va_ten], label[:ma_sinh_vien], label[:lop_hc]] }          
        end
        send_data p.to_stream.read, :filename => "lichtrucnhat-#{@lop.ma_lop + @lop.ma_mon_hoc}.xlsx", :type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet"
      }
    end
  end  
  def calendar
    authorize! :read, @lop_mon_hoc
    @lich = @lop_mon_hoc.get_days
    respond_to do |format|          
      format.html {render :calendar}            
    end
  end
  def showdkbs
    authorize! :manage, @lop_mon_hoc
    @sotietbs = @lop_mon_hoc.so_tiet_phan_bo - @lop_mon_hoc.khoi_luong_phan_bo

    if @lop_mon_hoc.da_duyet_bo_sung == true
      @sobuoibs = @lop_mon_hoc.so_buoi_bo_sung
    end    
    respond_to do |format|
      format.js
    end
  end
  def dkbs
    authorize! :manage, @lop_mon_hoc
    @sobuoibs = params[:sobuoibs].to_i
    @sotietbs = params[:sotietbs].to_i

    if @sobuoibs > 0
      @lop_mon_hoc.da_duyet_bo_sung = false
      @lop_mon_hoc.so_tiet_bo_sung = @sotietbs
      @lop_mon_hoc.so_buoi_bo_sung = @sobuoibs
      @lop_mon_hoc.save!
    end

    respond_to do |format|
      format.js
    end
  end
  def qldkbs
    authorize! :manage, @lop_mon_hoc

    respond_to do |format|
      format.js
    end
  end
  protected
  def load_lop
    @lop_mon_hoc ||= LopMonHoc.find(params[:id])
  end
  private
  def render_svvang(lich)
    res = ""
    if lich.diem_danhs.count > 0
      res = "<ol>"
      lich.diem_danhs.each do |dd|
        res += "<li>#{dd.sinh_vien.to_s}</li>"
      end
      res += "</ol>"
    end
    return res
  end
  def render_lichtrinh(lichtrinhs)
    report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'reports', 'lichtrinh.tlf')

    lichtrinhs.each_with_index do |lich, index|
      report.list.add_row do |row|
        row.values no: index+1, 
                   tuan: lich.tuan.to_s, 
                   thoigian: format_date2(lich.ngay_day) + (lich.loai == 2 ? "<br/> <i><strong>( dạy bù vào #{format_date2(lich.ngay_day_moi)} </strong></i>)" : "" ), 
                   noidung: (lich.noi_dung_day.gsub(/\n/,'<br/>') if lich.noi_dung_day) || "",
                   sotiet: lich.so_tiet_day_moi,
                   phong: lich.phong_moi || "",
                   svvang: render_svvang(lich)
        
      end
    end
    
    send_data report.generate, filename: 'lichtrinh.pdf', 
                               type: 'application/pdf', 
                               disposition: 'attachment'
  end
end
