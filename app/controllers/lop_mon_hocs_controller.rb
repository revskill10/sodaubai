# encoding: UTF-8
require 'zip/zip'
class LopMonHocsController < ApplicationController  
  
  include DashboardHelper
  include LopMonHocsHelper  
  before_filter :authenticate_user!
  before_filter :load_lop, :except => :index

  def nhapdiemthang3
    authorize! :manage, @lop_mon_hoc
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    respond_to do |format|
      format.html
    end
  end
  def postnhapdiemthang3
    authorize! :manage, @lop_mon_hoc
    if @lop_mon_hoc.thang3 == true
      @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
      
      @msvs = params[:msv]
      @svs.each do   |sv|      
        if @msvs[sv.ma_sinh_vien]        
          sv.diem_chuyen_can = @msvs[sv.ma_sinh_vien][:diemcc].to_i if @msvs[sv.ma_sinh_vien][:diemcc].present? and @msvs[sv.ma_sinh_vien][:diemcc].to_i >= 0 and @msvs[sv.ma_sinh_vien][:diemcc].to_f <= 4
          if @lop_mon_hoc.get_thuc_hanh == true
            sv.diem_thuc_hanh = @msvs[sv.ma_sinh_vien][:thuchanh].to_i if @msvs[sv.ma_sinh_vien][:thuchanh].present? and @msvs[sv.ma_sinh_vien][:thuchanh].to_i >= 0 and @msvs[sv.ma_sinh_vien][:thuchanh].to_f <= 3
            sv.diemth = sv.diemth2
          end
          sv.diem_tbkt = @msvs[sv.ma_sinh_vien][:diemtbkt].to_i if @msvs[sv.ma_sinh_vien][:diemtbkt].present? and @msvs[sv.ma_sinh_vien][:diemtbkt].to_i >= 0 and @msvs[sv.ma_sinh_vien][:diemtbkt].to_i <= (@lop_mon_hoc.get_thuc_hanh == true ? 3 : 6)
          sv.diem_qua_trinh = sv.diemqt
          if sv.diem_chuyen_can == 0 
            sv.note = "TC"
          else
            sv.note = nil
          end
          #sv.create_activity key: "lop_mon_hoc_sinh_vien.updatediemththang3", params: {diemcc: sv.diem_chuyen_can, thuchanh: sv.diem_thuc_hanh, tbkt: sv.diem_tbkt}, owner: current_user, recipient: sv.sinh_vien if test == true
          sv.save! rescue puts "error"
        end
      end
      respond_to do |format|
        format.js
      end
    else
      @error = 1
      respond_to do |format|
        format.js
      end
    end
  end
  def update_hoten
    authorize! :manage, @lop_mon_hoc
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    if @svs and @svs.count > 0
      @svs.each do |lsv|
        sv = lsv.sinh_vien if lsv        
        if sv 
          lsv.ho = sv.ho
          lsv.ho_dem = sv.ho_dem
          lsv.ten = sv.ten
          lsv.save!
        end
      end
    end
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    respond_to do |format|
      format.js
    end
  end  
  def update_diemqt
    authorize! :manage, @lop_mon_hoc
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    if @svs and @svs.count > 0
      @svs.each do |sv|
        sv.diem_goc_tbkt = sv.diemtbkt1
        sv.diem_tbkt = sv.diemtbkt         
        sv.diemth = sv.diemth2
        sv.diem_qua_trinh = sv.diemqt
        if sv.diem_chuyen_can == 0 
          sv.note = "TC"
        else
          sv.note = nil
        end
        sv.save!
      end
    end
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    respond_to do |format|
      format.js
    end
  end  
  def update_diemcc
    authorize! :manage, @lop_mon_hoc
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    if @svs and @svs.count > 0
      @svs.each do |sv|
        sv.tong_so_tiet = @lop_mon_hoc.so_tiet
        sv.so_vang_co_phep = @lop_mon_hoc.lich_trinh_giang_days.where("loai is NULL or loai != 1").inject(0){|sum,x| sum + x.diem_danhs.where(ma_sinh_vien: sv.ma_sinh_vien).sum(:so_tiet_vang, :conditions => {:phep => true}) }
        sv.so_tiet_vang =  @lop_mon_hoc.lich_trinh_giang_days.where("loai is NULL or loai != 1").inject(0){|sum,x| sum + x.diem_danhs.where(ma_sinh_vien: sv.ma_sinh_vien).sum(:so_tiet_vang) }
        sv.diem_chuyen_can = sv.diemcc
        sv.diem_goc_tbkt = sv.diemtbkt1
        sv.diem_tbkt = sv.diemtbkt        
        sv.diemth = sv.diemth2  
        sv.diem_qua_trinh = sv.diemqt
        if sv.diem_chuyen_can == 0 
          sv.note = "TC"
        else
          sv.note = nil
        end
        sv.save!
      end
    end
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    respond_to do |format|
      format.js
    end
  end  
  def tinhhinh
    authorize! :report, @lop_mon_hoc  
    @ld = @lop_mon_hoc.decorate    
    QC.enqueue "GoogleAnalytic.perform", {:category => "LopMonHoc", :action => "tinhhinh", :label => "#{current_user.username}", :value => "1"}.to_json
    send_data @ld.tinhhinh(@current_tenant).render, filename: "theo_doi_lop_#{@lop_mon_hoc.ma_lop}_#{@lop_mon_hoc.ma_giang_vien}.pdf", 
                      type: "application/pdf"
  end
  def lichtrinh
    authorize! :report, @lop_mon_hoc        
    @ld = @lop_mon_hoc.decorate    
    QC.enqueue "GoogleAnalytic.perform", {:category => "LopMonHoc", :action => "lichtrinh", :label => "#{current_user.username}", :value => "1"}.to_json
    send_data @ld.lichtrinh(@current_tenant).render, filename: "lich_trinh_lop_#{@lop_mon_hoc.ma_lop}_#{@lop_mon_hoc.ma_giang_vien}.pdf", 
                          type: "application/pdf"
  end  
  def phieudiem
    authorize! :report, @lop_mon_hoc    
    @ld = @lop_mon_hoc.decorate    
    QC.enqueue "GoogleAnalytic.perform", {:category => "LopMonHoc", :action => "phieudiem", :label => "#{current_user.username}", :value => "1"}.to_json
    send_data @ld.phieudiem(@current_tenant), filename: "phieudiem_lop_#{@lop_mon_hoc.ma_lop}_#{@lop_mon_hoc.ma_giang_vien}.zip", 
                          type: "application/zip"
  end
  def index
    authorize! :read, @lop_mon_hoc
    @lops = LopMonHoc.find(:all, :order => "id desc", :limit => 3)    
    QC.enqueue "GoogleAnalytic.perform", {:category => "LopMonHoc", :action => "index", :label => "#{current_user.username}", :value => "1"}.to_json
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
    @lichs = @lop_mon_hoc.lich_trinh_giang_days.order('tuan, ngay_day_moi, ngay_day')
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens    
    QC.enqueue "GoogleAnalytic.perform", {:category => "LopMonHoc", :action => "report", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|
      format.html
    end

  end
  def show
    authorize! :quanly, @lop_mon_hoc if current_user.is_a?(GiangVien)
    authorize! :read, @lop_mon_hoc if current_user.is_a?(SinhVien)
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    
    @lichs = @lop_mon_hoc.lich_trinh_giang_days.where('char_length(noi_dung_day) > 0').order('ngay_day, tuan')    
    QC.enqueue "GoogleAnalytic.perform", {:category => "LopMonHoc", :action => "show", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|      
      format.html {render :show}
      #format.pdf { render_lichtrinh(@lichs) }
    end    
  end
  def export_lichtrinh
    authorize! :manage, @lop_mon_hoc
    @lichs = @lop_mon_hoc.lich_trinh_giang_days.where('char_length(noi_dung_day) > 0').order('ngay_day, tuan')
    @sotuan = @lichs.pluck(:tuan).uniq.count    
    QC.enqueue "GoogleAnalytic.perform", {:category => "LopMonHoc", :action => "export_lichtrinh", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|
      format.html
    end
  end
  def tuan
    authorize! :quanly, @lop_mon_hoc if current_user.is_a?(GiangVien)
    authorize! :read, @lop_mon_hoc if current_user.is_a?(SinhVien)
    @lop_mon_hoc = LopMonHoc.find(params[:id])
    @lichlop = @lop_mon_hoc.get_days
    @lich = @lichlop.select {|l| l["tuan"] == params[:tuan_id].to_i}.uniq if @lichlop
    QC.enqueue "GoogleAnalytic.perform", {:category => "LopMonHoc", :action => "tuan", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|
      format.html { render 'calendar'}
    end
  end  
  def update
    authorize! :manage, @lop_mon_hoc
    @sn = params[:so_nhom].to_s.empty? ? 1 : params[:so_nhom].to_i
    @sl = params[:so_lan_kt].to_s.empty? ? 0 : params[:so_lan_kt].to_i
    th = params[:thuc_hanh]
    @thang3 = params[:thang3] ? true : false
    if @lop_mon_hoc.bosung != true
      @st = (params[:so_tiet_phan_bo] and params[:so_tiet_phan_bo].empty?) ? @lop_mon_hoc.so_tiet : params[:so_tiet_phan_bo].to_f
    end
    
    if @sn <= 0 then @sn = 1 end
    @lop_mon_hoc.update_attributes(group: @sn, so_lan_kt: @sl, so_tiet_phan_bo: @st, thang3: @thang3) if @sl >= 0 and @sl <= 5 and @sn >= 1 and @lop_mon_hoc.bosung != true
    @lop_mon_hoc.update_attributes(group: @sn, so_lan_kt: @sl) if @sl >= 0 and @sl <= 5 and @sn >= 1 and @lop_mon_hoc.bosung == true
    @lop_mon_hoc.thuc_hanh = true if th
    @lop_mon_hoc.thuc_hanh = false unless th
    @lop_mon_hoc.da_day_xong = params[:da_day_xong]

    if @lop_mon_hoc.save! then 
      @lop_mon_hoc_sinh_viens = @lop_mon_hoc.lop_mon_hoc_sinh_viens
      @lop_mon_hoc_sinh_viens.update_all(:group_id => 1) if @sn == 1 
      @group = @lop_mon_hoc.group || 1
      @groups_arrays = {}
      @group.times do |g|
        @groups_arrays[(g+1).to_s] = "Nhóm #{g+1}"
      end      
      QC.enqueue "GoogleAnalytic.perform", {:category => "LopMonHoc", :action => "update", :label => "#{current_user.username}", :value => "1"}.to_json
      respond_to do |format|
        if @lop_mon_hoc.da_day_xong then 
          format.js { render :update2 }
        else
          format.js
        end
      end
    end
  end


  def search
    authorize! :search, LopMonHoc

    @lop = LopMonHoc.find(params[:id])    
    @lichtrucnhat = @lop.convert_trucnhat if @lop.trucnhat    
    QC.enqueue "GoogleAnalytic.perform", {:category => "LopMonHoc", :action => "search", :label => "#{current_user.username}", :value => "1"}.to_json
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
    authorize! :quanly, @lop_mon_hoc if current_user.is_a?(GiangVien)
    authorize! :read, @lop_mon_hoc if current_user.is_a?(SinhVien)
    @lich = @lop_mon_hoc.get_days  
    @lichbs = @lop_mon_hoc.lich_trinh_giang_days.where(loai: [2,5]).order("tuan")
    QC.enqueue "GoogleAnalytic.perform", {:category => "LopMonHoc", :action => "calendar", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|          
      format.html {render :calendar}            
    end
  end
  def showdkbs
    authorize! :manage, @lop_mon_hoc
    #@sotietbs = @lop_mon_hoc.so_tiet_phan_bo - @lop_mon_hoc.khoi_luong_phan_bo

    #if @lop_mon_hoc.da_duyet_bo_sung == true
    #  @sobuoibs = @lop_mon_hoc.so_buoi_bo_sung
    #end        
    #QC.enqueue "GoogleAnalytic.perform", {:category => "LopMonHoc", :action => "showdkbs", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|
      format.js
    end
  end
  def dkbs
    authorize! :manage, @lop_mon_hoc
    @sobuoibs = params[:sobuoibs].to_i
    #@sotietbs = params[:sotietbs].to_f.round(0).to_i

    if @sobuoibs > 0
      #@lop_mon_hoc.bosung = true
      #@lop_mon_hoc.da_duyet_bo_sung = false
      #@lop_mon_hoc.so_tiet_bo_sung = @sotietbs
      @lop_mon_hoc.so_buoi_bo_sung = @sobuoibs
      @lop_mon_hoc.save!
    else 
      @error = 1
    end    
    QC.enqueue "GoogleAnalytic.perform", {:category => "LopMonHoc", :action => "dkbs", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|
      format.js
    end
  end
  def qldkbs    
    authorize! :manage, @lop_mon_hoc
    #begin
    @dkbs = params[:dkbs]    
    if @dkbs and @dkbs.keys.count > 0
      @dkbs.each do |k,v|
        @day = v["day"].split("/").to_a
        @sotiet = v["sotiet"].to_i
        @phong = v["phong"]
        @tietbatdau = LichTrinhGiangDay::TIET[v[:tietbatdau].to_i]
        ngay_day = DateTime.new(@day[2].to_i, @day[1].to_i, @day[0].to_i, @tietbatdau[0], @tietbatdau[1]).change(:offset => Rational(7,24))        
        @lop_mon_hoc.lich_trinh_giang_days.create!(ngay_day: ngay_day, so_tiet_day: @sotiet, phong_moi: @phong, loai: 5, status: 6) if @sotiet > 0        
      end    
      #@lop_mon_hoc.bosung = true      
      @lop_mon_hoc.so_tiet_bo_sung = 0
      @lop_mon_hoc.save!
      @lichdkbs = @lop_mon_hoc.lich_trinh_giang_days.where(loai: 5)
    end      
    QC.enqueue "GoogleAnalytic.perform", {:category => "LopMonHoc", :action => "qldkbs", :label => "#{current_user.username}", :value => "1"}.to_json
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
