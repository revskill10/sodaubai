# encoding: UTF-8
require 'zip/zip'
class LopMonHocsController < ApplicationController  
  
  include DashboardHelper
  include LopMonHocsHelper  
  before_filter :authenticate_user!
  before_filter :load_lop, :except => :index
  
  def tinhhinh
    authorize! :manage, @lop_mon_hoc  
    @ld = @lop_mon_hoc.decorate
    send_data @ld.tinhhinh(@current_tenant).render, filename: "theo_doi_lop_#{@lop_mon_hoc.ma_lop}_#{@lop_mon_hoc.ten_giang_vien}.pdf", 
                      type: "application/pdf"
  end
  def lichtrinh
    authorize! :manage, @lop_mon_hoc    
    #output = LichReport.new(@lop_mon_hoc).to_pdf    
    #@lichs = @lop_mon_hoc.lich_trinh_giang_days.where('char_length(noi_dung_day) > 0').order('ngay_day, tuan')
    @ld = @lop_mon_hoc.decorate
    send_data @ld.lichtrinh(@current_tenant).render, filename: "lich_trinh_lop_#{@lop_mon_hoc.ma_lop}_#{@lop_mon_hoc.ten_giang_vien}.pdf", 
                          type: "application/pdf"
  end  
  def phieudiem
    authorize! :manage, @lop_mon_hoc    
    respond_to do |format|
      format.zip do
        
        svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
        tinchi = @lop_mon_hoc.lop_mon_hoc_sinh_viens.where(lop_tin_chi: true)
        nienche = svs - tinchi

        if nienche.count > 0
          niencheitems = nienche.each_with_index.map do |item, i|
            [
              i+1,
              item.ma_sinh_vien,            
              item.sinh_vien.hovaten,
              (item.ngay_sinh ? item.ngay_sinh.strftime("%d/%m/%Y") : ""),
              item.ma_lop_hanh_chinh
            ]            
          end   
          niencheitems2 = nienche.each_with_index.map do |item, i|
            [              
              item.diemcc,
              item.diemth.to_s,
              item.diemtbkt,
              item.diemqt,
              item.lop_ghep.to_s
            ]            
          end                            
        end
        if tinchi.count > 0
          tis = [tinchi[0..27]] + (tinchi[27..-1]||[]).each_slice(35).to_a          
        end
        if nienche.count > 0
          tis2 = [nienche[0..27]] + (nienche[27..-1]||[]).each_slice(35).to_a          
        end


        
        #stringio = Zip::ZipOutputStream::write_buffer do |zio|
          if tis
         #   zio.put_next_entry("phieudiem_tinchi.pdf")
            pdf = Prawn::Document.new(:page_layout => :portrait,         
            :page_size => 'A4', :margin => 30)
            #pdf.font "#{Rails.root}/app/assets/fonts/arial2.ttf"
            pdf.font_families.update(
              'Arial' => { :normal => Rails.root.join('app/assets/fonts/arial2.ttf').to_s,
                           :bold   => Rails.root.join('app/assets/fonts/arialbd.ttf').to_s,
                           :italic => Rails.root.join('app/assets/fonts/arialbi.ttf').to_s}                       
            )                        
            cell_width = 50
            row_height = 120
            img_path = "#{Rails.root}/public/images/logo.png"
            tab1 = pdf.make_table [["TRƯỜNG ĐẠI HỌC DÂN LẬP HẢI PHÒNG"],["PHÒNG ĐÀO TẠO"]], :width => 250, :cell_style => { :font_style => :bold, :size => 11, :borders => [], :align => :center, :valign => :center }
            tab2 = pdf.make_table [["PHIẾU ĐIỂM QUÁ TRÌNH"],["Lớp: #{@lop_mon_hoc.ma_lop} Học kỳ: #{@current_tenant.hoc_ky} Năm học: #{@current_tenant.nam_hoc}\n\nMôn học: #{@lop_mon_hoc.ten_mon_hoc}\n\nGiảng viên: #{@lop_mon_hoc.ten_giang_vien} "]], :width => 210, :cell_style => {:borders => []} do 
              row(0).columns(0).font_style = :bold
              row(0).columns(0).padding_left = 20
              row(0).columns(0).valign = :center
              row(0).columns(0).size = 11
              row(1).columns(0).size = 9
            end

            pieces = [[img_path, ""]]
            pieces.each do |p|
            #pdf.move_down 5 # a bit of padding
            cursor = pdf.cursor 
            p.each_with_index do |v,j|
               pdf.bounding_box [cell_width*j, cursor], :height => row_height, :width => ( j == 0 ? cell_width : 460) do
                if j == 0
                  pdf.image v, :width => 40
                else
                  #pdf.text v, :size => 10 unless v.blank?
                  pdf.font "Arial"
                  pdf.table [
                    [tab1, tab2]
                  ], :cell_style => {:borders => []}, :width => 460

                end
              end
            end
          end
          prev = 0
          tis.each_with_index do |ti, index|

            tinchiitems = ti.each_with_index.map do |item,i|
              [
                (index * prev) + i+1,
                item.ma_sinh_vien,            
                item.sinh_vien.hovaten,
                (item.ngay_sinh ? item.ngay_sinh.strftime("%d/%m/%Y") : ""),
                item.ma_lop_hanh_chinh              
              ]  
            end      
            tinchiitems2 = ti.each_with_index.map do |item,i|
              [              
                item.diemcc,
                item.diemth.to_s,
                item.diemtbkt,
                item.diemqt                
              ]  
            end   
            tinchiitems3 = ti.each_with_index.map do |item,i|
              [              
                (item.lop_ghep ? "Ghép lớp" : "")
              ]
            end

            h1 = pdf.make_table [["STT","Mã SV","Họ và tên","Ngày sinh","Lớp"]], :width => 280, :cell_style => {:size => 6.5, :align => :center, :valign => :center, :height => 60}, :column_widths => {0 => 30, 1 => 60, 2 => 90, 3 => 50, 4 => 50}
            h11 = pdf.make_table tinchiitems, :cell_style => {:size => 6.5, :align => :center, :height => 17}, :column_widths => {0 => 30, 1 => 60, 2 => 90, 3 => 50, 4 => 50}, :width => 280 do 
              tinchiitems.length.times do |i|
                row(i).columns(2).align = :left
              end
            end
            h111 = pdf.make_table [
              [h1],
              [h11]
            ]
            h21 = pdf.make_table [["Nội dung"]], :cell_style => {:size => 6.5, :align => :center, :height => 20}, :width => 200
            h22 = pdf.make_table [["Chuyên cần 4/10","Thực hành, TN, Tiểu luận 3/10","Kiểm tra thường xuyên 3/10","Tổng điểm"]], :cell_style => {:height => 40, :size => 7, :align => :center}, :column_widths => {0 => 50, 1 => 50, 2 => 50, 3 => 50}, :width => 200
            h221 = pdf.make_table tinchiitems2, :cell_style => {:size => 6.5, :height => 17, :align => :center}, :width => 200, :column_widths => {0 => 50, 1 => 50, 2 => 50, 3 => 50}
            h222 = pdf.make_table [
              [h22],
              [h221]
            ]
            h2 = pdf.make_table [ 
              [h21],            
              [h222]                
            ]                
              
            h3 = pdf.make_table [["Ghi chú"]], :cell_style => {:size => 7, :height => 60, :align => :center, :valign => :center}, :width => 50
            h31 = pdf.make_table tinchiitems3, :cell_style => {:size => 6.5, :height => 17, :align => :center}, :width => 50
            h311 = pdf.make_table [
              [h3],
              [h31]
            ]
            pdf.table [
                  [
                    h111,
                    h2,
                    h311
                  ]
                ]
            pdf.move_down 50
            prev = ti.count
          end
            pdf.move_down 3
            pdf.text "Nơi gửi: Phòng Đào tạo", :size => 7
            pdf.table [["","Hải Phòng, ngày         tháng        năm"],["Chủ nhiệm bộ môn", "Giảng viên"]], :cell_style => {:size => 8, :borders => [], :align => :center}, :column_widths => {0 => 250, 1 => 250} do 
                row(0).columns(1).font_style = :italic
                row(0).columns(1).size = 7
                row(1).columns(0).font_style = :bold
                row(1).columns(1).font_style = :bold
            end
            pdf.repeat(:all) do 
              pdf.draw_text "HD01-B02", :at => [10, -10], :size => 8
            end
          
          end

       
         if tis2
         #   zio.put_next_entry("phieudiem_tinchi.pdf")
            pdf2 = Prawn::Document.new(:page_layout => :portrait,         
            :page_size => 'A4', :margin => 30)
            #pdf.font "#{Rails.root}/app/assets/fonts/arial2.ttf"
            pdf2.font_families.update(
              'Arial' => { :normal => Rails.root.join('app/assets/fonts/arial2.ttf').to_s,
                           :bold   => Rails.root.join('app/assets/fonts/arialbd.ttf').to_s,
                           :italic => Rails.root.join('app/assets/fonts/arialbi.ttf').to_s}                       
            )                        
            cell_width = 50
            row_height = 120
            img_path = "#{Rails.root}/public/images/logo.png"
            tab1 = pdf2.make_table [["TRƯỜNG ĐẠI HỌC DÂN LẬP HẢI PHÒNG"],["PHÒNG ĐÀO TẠO"]], :width => 250, :cell_style => { :font_style => :bold, :size => 11, :borders => [], :align => :center, :valign => :center }
            tab2 = pdf2.make_table [["PHIẾU ĐIỂM QUÁ TRÌNH"],["Lớp: #{@lop_mon_hoc.ma_lop} Học kỳ: #{@current_tenant.hoc_ky} Năm học: #{@current_tenant.nam_hoc}\n\nMôn học: #{@lop_mon_hoc.ten_mon_hoc}\n\nGiảng viên: #{@lop_mon_hoc.ten_giang_vien} "]], :width => 210, :cell_style => {:borders => []} do 
              row(0).columns(0).font_style = :bold
              row(0).columns(0).padding_left = 20
              row(0).columns(0).valign = :center
              row(0).columns(0).size = 11
              row(1).columns(0).size = 9
            end

            pieces = [[img_path, ""]]
            pieces.each do |p|
            #pdf.move_down 5 # a bit of padding
            cursor = pdf2.cursor 
            p.each_with_index do |v,j|
               pdf2.bounding_box [cell_width*j, cursor], :height => row_height, :width => ( j == 0 ? cell_width : 460) do
                if j == 0
                  pdf2.image v, :width => 40
                else
                  #pdf.text v, :size => 10 unless v.blank?
                  pdf2.font "Arial"
                  pdf2.table [
                    [tab1, tab2]
                  ], :cell_style => {:borders => []}, :width => 460

                end
              end
            end
          end
          prev2 = 0
          tis2.each_with_index do |ti, index|            
            niencheitems = ti.each_with_index.map do |item,i|
              [
                (index * prev) + i+1,
                item.ma_sinh_vien,            
                item.sinh_vien.hovaten,
                item.ngay_sinh.strftime("%d/%m/%Y"),              
                item.ma_lop_hanh_chinh              
              ]  
            end      
            niencheitems2 = ti.each_with_index.map do |item,i|
              [              
                item.diemcc,
                item.diemth.to_s,
                item.diemtbkt,
                item.diemqt                
              ]  
            end   
            niencheitems3 = ti.each_with_index.map do |item,i|
              [              
                (item.lop_ghep ? "Ghép lớp" : "")
              ]
            end

            h1 = pdf2.make_table [["STT","Mã SV","Họ và tên","Ngày sinh","Lớp"]], :width => 280, :cell_style => {:size => 6.5, :align => :center, :valign => :center, :height => 60}, :column_widths => {0 => 30, 1 => 60, 2 => 90, 3 => 50, 4 => 50}
            h11 = pdf2.make_table niencheitems, :cell_style => {:size => 6.5, :align => :center, :height => 17}, :column_widths => {0 => 30, 1 => 60, 2 => 90, 3 => 50, 4 => 50}, :width => 280 do 
              niencheitems.length.times do |i|
                row(i).columns(2).align = :left
              end
            end
            h111 = pdf2.make_table [
              [h1],
              [h11]
            ]
            h21 = pdf2.make_table [["Nội dung"]], :cell_style => {:size => 6.5, :align => :center, :height => 20}, :width => 200
            h22 = pdf2.make_table [["Chuyên cần 4/10","Thực hành, TN, Tiểu luận 3/10","Kiểm tra thường xuyên 3/10","Tổng điểm"]], :cell_style => {:height => 40, :size => 7, :align => :center}, :column_widths => {0 => 50, 1 => 50, 2 => 50, 3 => 50}, :width => 200
            h221 = pdf2.make_table niencheitems2, :cell_style => {:size => 6.5, :height => 17, :align => :center}, :width => 200, :column_widths => {0 => 50, 1 => 50, 2 => 50, 3 => 50}
            h222 = pdf2.make_table [
              [h22],
              [h221]
            ]
            h2 = pdf2.make_table [ 
              [h21],            
              [h222]                
            ]                
              
            h3 = pdf2.make_table [["Ghi chú"]], :cell_style => {:size => 7, :height => 60, :align => :center, :valign => :center}, :width => 50
            h31 = pdf2.make_table niencheitems3, :cell_style => {:size => 6.5, :height => 17, :align => :center}, :width => 50
            h311 = pdf2.make_table [
              [h3],
              [h31]
            ]
            pdf2.table [
                  [
                    h111,
                    h2,
                    h311
                  ]
                ]                  
              pdf2.move_down 50        
              prev2 = ti.count
          end
            pdf2.move_down 3
            pdf2.text "Nơi gửi: Phòng Đào tạo", :size => 7
            pdf2.table [["","Hải Phòng, ngày         tháng        năm"],["Chủ nhiệm bộ môn", "Giảng viên"]], :cell_style => {:size => 8, :borders => [], :align => :center}, :column_widths => {0 => 250, 1 => 250} do 
                row(0).columns(1).font_style = :italic
                row(0).columns(1).size = 7
                row(1).columns(0).font_style = :bold
                row(1).columns(1).font_style = :bold
            end
            pdf2.repeat(:all) do 
              pdf2.draw_text "HD01-B02", :at => [10, -10], :size => 8
            end
          
          
          end
        stringio = Zip::ZipOutputStream::write_buffer do |zio|         
          if pdf 
           zio.put_next_entry("phieudiem_tinchi.pdf")
           zio.write pdf.render 
          end
          if pdf2
           zio.put_next_entry("phieudiem_nienche.pdf")
           zio.write pdf2.render
         end
        end
=begin          
          if nienche.count > 0
            zio.put_next_entry("phieudiem_nienche.pdf")
              pdf = Prawn::Document.new(:page_layout => :portrait,         
        :page_size => 'A4')
        #pdf.font "#{Rails.root}/app/assets/fonts/arial2.ttf"
        pdf.font_families.update(
          'Arial' => { :normal => Rails.root.join('app/assets/fonts/arial2.ttf').to_s,
                       :bold   => Rails.root.join('app/assets/fonts/arialbd.ttf').to_s,
                       :italic => Rails.root.join('app/assets/fonts/arialbi.ttf').to_s}                       
        )                        
        cell_width = 50
        row_height = 120
        img_path = "#{Rails.root}/public/images/logo.png"
        tab1 = pdf.make_table [["TRƯỜNG ĐẠI HỌC DÂN LẬP HẢI PHÒNG"],["PHÒNG ĐÀO TẠO"]], :width => 250
        tab2 = pdf.make_table [["PHIẾU ĐIỂM QUÁ TRÌNH"],["Lớp: #{@lop_mon_hoc.ma_lop} Học kỳ: #{@current_tenant.hoc_ky} Năm học: #{@current_tenant.nam_hoc}\nMôn học: #{@lop_mon_hoc.ten_mon_hoc}\nGiảng viên: #{@lop_mon_hoc.ten_giang_vien} "]], :width => 250
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
                    pdf.font "Arial"
                    pdf.table [
                      [tab1, tab2]
                    ]

                  end
                end
              end
            end
            pdf.table niencheitems, :width => 480
            zio.write pdf.render
          end
        end
        
=end      
        stringio.rewind
        binary_data = stringio.sysread
        send_data binary_data, filename: "phieudiem_lop_#{@lop_mon_hoc.ma_lop}_#{@lop_mon_hoc.ten_giang_vien}.zip", 
                          type: "application/zip"
         #send_data pdf.render, filename: "phieudiem_lop_#{@lop_mon_hoc.ma_lop}_#{@lop_mon_hoc.ten_giang_vien}.pdf", 
          #                type: "application/pdf"
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

    if @sobuoibs > 0 and @sobuoibs < @sotietbs
      #@lop_mon_hoc.bosung = true
      @lop_mon_hoc.da_duyet_bo_sung = false
      @lop_mon_hoc.so_tiet_bo_sung = @sotietbs
      @lop_mon_hoc.so_buoi_bo_sung = @sobuoibs
      @lop_mon_hoc.save!
    else 
      @error = 1
    end

    respond_to do |format|
      format.js
    end
  end
  def qldkbs    
    authorize! :manage, @lop_mon_hoc
    #begin
    @dkbs = params[:dkbs]
    if @dkbs and @dkbs.keys.count > 0 and !(@lop_mon_hoc.bosung == true)
      sotiet = 0
      @dkbs.each do |k,v|
        sotiet += v["sotiet"].to_i
      end
      if @lop_mon_hoc.so_tiet_bo_sung != sotiet then @error = 1 end        
    end
    if @dkbs and @dkbs.keys.count > 0 and !(@lop_mon_hoc.bosung == true) and @error.nil?
      @dkbs.each do |k,v|
        @day = v["day"].split("/").to_a
        @sotiet = v["sotiet"].to_i
        @tietbatdau = LichTrinhGiangDay::TIET[v[:tietbatdau].to_i]
        ngay_day = DateTime.new(@day[2].to_i, @day[1].to_i, @day[0].to_i, @tietbatdau[0], @tietbatdau[1])
        @lop_mon_hoc.lich_trinh_giang_days.create!(ngay_day: ngay_day, so_tiet_day: @sotiet, loai: 5, status: 6)
      end
      @lop_mon_hoc.bosung = true
      @lop_mon_hoc.save!
      @lichdkbs = @lop_mon_hoc.lich_trinh_giang_days.where(loai: 5)
    end
    #rescue
     # @error = 1
    #end
    
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
