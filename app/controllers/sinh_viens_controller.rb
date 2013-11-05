# encoding: utf-8
class SinhViensController < ApplicationController
  # GET /sinh_viens
  # GET /sinh_viens.json
  include LopMonHocsHelper
  before_filter :authenticate_user!  
  before_filter :load_lop  , :except => :show
  def index        
    authorize! :read, SinhVien
    @sinh_vien = SinhVien.where(ma_sinh_vien: params[:id]).first
    @lops = @sinh_vien.lop_mon_hocs
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sinh_viens }
    end
  end
  
  def show    
    @sinh_vien = SinhVien.where(ma_sinh_vien: params[:id]).first
    raise ActiveRecord::RecordNotFound unless @sinh_vien    
    @lichs = @sinh_vien.lich_trinh_giang_days.sort_by {|l| [l.ngay_day, l.tuan]}
    @lichvangs = @sinh_vien.lich_vangs.map(&:id)

    respond_to do |format|
      format.html
      format.pdf do
        pdf = Prawn::Document.new(:page_layout => :landscape,         
        :page_size => 'A4')        
        pdf.font_families.update(
          'Arial' => { :normal => Rails.root.join('app/assets/fonts/arial2.ttf').to_s,
                       :bold   => Rails.root.join('app/assets/fonts/arialbd.ttf').to_s,
                       :italic => Rails.root.join('app/assets/fonts/arialbi.ttf').to_s}                       
        )
        pdf.font "Arial"
        cell_width = 40
    row_height = 120
    img_path = "#{Rails.root}/public/images/logo.png"
    pieces = [[img_path, ""]]
    pieces.each do |p|
      #pdf.move_down 5 # a bit of padding
      cursor = pdf.cursor 
      p.each_with_index do |v,j|
         pdf.bounding_box [cell_width*j, cursor], :height => 80, :width => ( j == 0 ? cell_width : 780) do
          if j == 0
            pdf.image v, :width => 40
          else                
            pdf.font "Arial"
            t1 = pdf.make_table [["BỘ GIÁO DỤC VÀ ĐÀO TẠO"],["TRƯỜNG ĐẠI HỌC DÂN LẬP HẢI PHÒNG"],[""],[""]], :width => 260, :cell_style => {:align => :center, :valign => :center, :size => 10, :height => 20, :borders => []}
            t2 = pdf.make_table [["      LỊCH TRÌNH HỌC SINH VIÊN #{@sinh_vien.ma_sinh_vien}"]], :width => 480, :cell_style => {:valign => :center, :size => 10, :font_style => :bold, :height => 20, :borders => []} do 
              row(0).columns(0).padding_left = 40
            end
                         
            t4 = pdf.make_table [[t2]], :cell_style => {:borders => []}
            t0 = pdf.make_table [[""]], :width => 20, :cell_style => {:borders => []}
            pdf.table [ 
              [     
                t0,
                t1,
                t0,              
                t4                   
              ]
            ] , :cell_style => {:borders => []}
          end
        end
      end
    end
    pdf.move_down(5)
        items = @lichs.map.each_with_index do |lich, index|
          [
            (index+1).to_s,            
            lich.tuan.to_s,
            format_date2(lich.ngay_day),
            (lich.phong_moi || ""),
            lich.lop_mon_hoc.ten_giang_vien,
            lich.lop_mon_hoc.ma_lop,
            lich.lop_mon_hoc.ten_mon_hoc,
            lich.so_tiet_day_moi || 0,
            lich.noi_dung_day || "",
            ("Vắng" if lich.diem_danhs.pluck(:ma_sinh_vien).include?(@sinh_vien.ma_sinh_vien))
          ]
        end        
        items.unshift ["STT","Tuần","Ngày học","Phòng","Tên giảng viên","Mã lớp","Tên môn học","Số tiết","Nội dung","Vắng"]
        pdf.table items, :header => true, :column_widths => {2 => 80, 3 => 50, 5 => 60 , 4 => 130,8 => 250, 9 => 50}, :cell_style => { :size => 8.5} do 
          (0..9).each do |i|
            row(0).columns(i).align = :center
          end
          items.count.times do |k|
            row(k).columns(2).align = :center
            [0,1,2,3,4,5,6,7,9].each do |i|
              row(k).columns(i).align = :center
              row(k).columns(i).valign = :center
            end
          end
        end
        send_data pdf.render, filename: "#{@sinh_vien.ma_sinh_vien}.pdf", 
                          type: "application/pdf"             
      end
    end
  end
  
  protected
  def load_lop
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])
  end
    
end
