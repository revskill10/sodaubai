# encoding: utf-8
require 'hpu'

class LopMonHocDecorator < Draper::Decorator
  delegate_all
  include HPU
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def tinhhinh(tenant)
  	sql = <<-eos  
        select row_number() OVER(ORDER BY t.ten, t.ho_dem, t.ho) as "stt", t."msv",
concat(t."ho" ,' ', t.ho_dem,' ', t.ten) as "hovaten",  to_char(t.ngay_sinh,'DD/MM/YYYY' ) as "ngaysinh",
case when t."T1"=0 then NULL else t."T1" end as "T1", case when t."T2"=0 then NULL else t."T2" end as "T2", 
case when t."T3"=0 then NULL else t."T3" end as "T3", case when t."T4"=0 then NULL else t."T4" end as "T4",
case when t."T5"=0 then NULL else t."T5" end as "T5", case when t."T6"=0 then NULL else t."T6" end as "T6", 
case when t."T7"=0 then NULL else t."T7" end as "T7", case when t."T8"=0 then NULL else t."T8" end as "T8", 
case when t."T9"=0 then NULL else t."T9" end as "T9", case when t."T10"=0 then NULL else t."T10" end as "T10", 
case when t."T11"=0 then NULL else t."T11" end as "T11", case when t."T12"=0 then NULL else t."T12" end as "T12",
case when t."T13"=0 then NULL else t."T13" end as "T13", case when t."T14"=0 then NULL else t."T14" end as "T14",
case when t."T15"=0 then NULL else t."T15" end as "T15", case when t."T16"=0 then NULL else t."T16" end as "T16",
COALESCE("T1",0) + COALESCE("T2",0)+ COALESCE("T3",0)+ COALESCE("T4",0)
    + COALESCE("T5",0)+ COALESCE("T6",0)+ COALESCE("T7",0)+ COALESCE("T8",0)+ COALESCE("T9",0)+ COALESCE("T10",0)
    + COALESCE("T11",0)+ COALESCE("T12",0)+ COALESCE("T13",0)+ COALESCE("T14",0)+ COALESCE("T15",0)
    + COALESCE("T16",0) as tonggiovang, t.diemchuyencan, t.diemthuchanh,
    t.lan1 as lan1, t.lan2 as lan2, t.lan3 as lan3, round(t.diemgoctbkt, 2) as diemgoctbkt, t.diemtbkt,  case when t.diemchuyencan=0 then 0 else t.diemquatrinh end as diemquatrinh,
    t.note as note
 from 
(SELECT "msv", sv1.ho, sv1.ho_dem, sv1.ten, sv1.ngay_sinh , "T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8", "T9", "T10", "T11",
    "T12", "T13", "T14", "T15", "T16",  COALESCE("T1",0) + COALESCE("T2",0)+ COALESCE("T3",0)+ COALESCE("T4",0)
    + COALESCE("T5",0)+ COALESCE("T6",0)+ COALESCE("T7",0)+ COALESCE("T8",0)+ COALESCE("T9",0)+ COALESCE("T10",0)
    + COALESCE("T11",0)+ COALESCE("T12",0)+ COALESCE("T13",0)+ COALESCE("T14",0)+ COALESCE("T15",0)
    + COALESCE("T16",0) as tonggiovang, sv1.diem_chuyen_can as diemchuyencan, sv1.diem_thuc_hanh as diemthuchanh,
    sv1.lan1 as lan1, sv1.lan2 as lan2, sv1.lan3 as lan3, sv1.diem_goc_tbkt as diemgoctbkt, sv1.diem_tbkt as diemtbkt,  sv1.diem_qua_trinh as diemquatrinh,
    sv1.note as note
    FROM crosstab(
      'select dd.ma_sinh_vien, l.tuan, sum(CASE WHEN phep THEN 0 ELSE so_tiet_vang END ) as so_vang
    from t1.diem_danhs dd
    inner join t1.lich_trinh_giang_days l on l.id = dd.lich_trinh_giang_day_id
    where l.lop_mon_hoc_id = #{object.id}
    and dd.so_tiet_vang > 0
    group by ma_sinh_vien, tuan
    order by 1,2',
    'select m from generate_series(1,16) m')
    AS ("msv" text, "T1" int, "T2" int, "T3" int, "T4" int, "T5" int, "T6" int, "T7" int, "T8" int, "T9" int, "T10" int
    , "T11" int, "T12" int, "T13" int, "T14" int, "T15" int, "T16" int)
    inner join t1.lop_mon_hoc_sinh_viens sv1 on sv1.ma_sinh_vien = msv and sv1.lop_mon_hoc_id = #{object.id}

    union all
    select ma_sinh_vien as "msv", ho, ho_dem, ten, ngay_sinh, 0 as "T1", 0 as "T2", 
    0 as "T3", 0 as "T4", 0 as "T5", 0 as "T6", 
0 as "T7", 0 as "T8", 0 as "T9", 0 as "T10", 0 as "T11", 0 as "T12", 
0 as "T13", 0 as "T14", 0 as "T15", 0 as "T16", 0 as tongiovang , diem_chuyen_can , diem_thuc_hanh as diemthuchanh,
lan1, lan2, lan3, diem_goc_tbkt as diemgoctbkt, diem_tbkt as diemtbkt, diem_qua_trinh as diemquatrinh, note as note
from t1.lop_mon_hoc_sinh_viens where lop_mon_hoc_id=#{object.id} and ma_sinh_vien not in (select dd.ma_sinh_vien
    from t1.diem_danhs dd
    inner join t1.lich_trinh_giang_days l on l.id = dd.lich_trinh_giang_day_id
    where l.lop_mon_hoc_id = #{object.id}
    and dd.so_tiet_vang > 0)
 ) as t
 order by t.ten, t.ho_dem, t.ho, t.ngay_sinh
    eos
    @res = ActiveRecord::Base.connection.execute(sql)    
    
    pdf = Prawn::Document.new(:page_layout => :landscape,         
    :page_size => 'A4', :margin => 20)
    #pdf.font "#{Rails.root}/app/assets/fonts/arial.ttf"
    pdf.font_families.update(
      'Arial' => { :normal => Rails.root.join('app/assets/fonts/arial2.ttf').to_s,
                   :bold   => Rails.root.join('app/assets/fonts/arialbd.ttf').to_s,
                   :italic => Rails.root.join('app/assets/fonts/arialbi.ttf').to_s}                       
    )
    
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
            t2 = pdf.make_table [["      BẢNG THEO DÕI TÌNH HÌNH MÔN HỌC"]], :width => 480, :cell_style => {:valign => :center, :size => 10, :font_style => :bold, :height => 20, :borders => []} do 
              row(0).columns(0).padding_left = 40
            end
            t3 = pdf.make_table [
              ["Môn học: #{object.ten_mon_hoc}","", "Tổng số tiết:....."],
              ["Giáo viên phụ trách: #{object.ten_giang_vien}","", "Lý thuyết:....."],
              ["Lớp: #{object.ma_lop} Kỳ: #{tenant.hoc_ky} Năm học: #{tenant.nam_hoc}","", "Thực hành, thí nghiệm:....."]
            ], :cell_style => {:size => 9, :height => 20, :borders => []}, :width => 480, :column_widths => { 0 => 210, 1 => 100, 2 => 170} do 
              row(0).columns(0).font_style = :bold
            end                

            t4 = pdf.make_table [[t2], [t3]], :cell_style => {:borders => []}
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
    @res = @res.to_a
    m = @res.each_slice(19).to_a if @res.count <= 19
    if @res.count > 19
      m1 = @res[0..18]
      m2 = @res[19..-1].each_slice(23).to_a
      m = m2.unshift(m1)
    end
    page_count = m.count
    m.each_with_index do |m1, index|
    pdf.font "Arial"  
    items1 = m1.map {|i| [i["stt"], i["msv"], i["hovaten"], i["ngaysinh"]]}        
    mtable01 = pdf.make_table [["Stt", "Mã SV", "Họ và tên", "Ngày sinh"]], :width => 240, :cell_style => {:align => :center, :valign => :center, :size => 7.5, :height => 50}, :column_widths => {1 => 52, 2 => 115, 3 => 50}
    mtable02 = pdf.make_table items1, :width => 240, :cell_style => {:align => :center, :valign => :center, :size => 7.5, :height => 20}, :column_widths => {1 => 52, 2 => 115, 3 => 50} do 
      (0..items1.length).each do |l|
        row(l).columns(2).align = :left
      end
    end

    items2 = m1.map {|item| 
      [item["T1"],item["T2"],item["T3"],item["T4"],item["T5"],item["T6"],item["T7"],item["T8"],item["T9"],item["T10"],item["T11"],item["T12"],item["T13"],item["T14"],item["T15"],item["T16"],
        item["tonggiovang"], item["diemchuyencan"]]}
    items3 = @res.map {|item| [item["lan1"], item["lan2"], item["lan3"], item["diemtbkt"]]}        
    mytable0 = pdf.make_table [["Điểm danh"]], :width => 370, :cell_style => {:align => :center, :valign => :center, :size => 7.5, :height => 20, :font_style => :bold}
    mytable01 = pdf.make_table [["T1","T2","T3","T4","T5","T6","T7","T8","T9","T10","T11","T12","T13","T14","T15","T16","Tổng giờ vắng", "Điểm chuyên cần"]] + items2, :width => 370, :cell_style => {:align => :center, :valign => :center, :size => 7, :height => 20}, :header => true do 
      (0..items2.length).each do |l|            
        row(l).columns(16).width = 25
        row(l).columns(17).width = 25
      end
      row(0).columns(16).size = 5
      row(0).columns(17).size = 5                    
      (0..17).each do |t|
        row(0).columns(t).height = 30            
      end

    end

    items3 = m1.map {|i| [i["diemthuchanh"]]}        
    mtable11 = pdf.make_table [["Điểm TH, TN, BTL, ĐA"]] + items3, :width => 22, :cell_style => {:align => :center, :valign => :center, :size => 7, :height => 20} do           
        row(0).columns(0).height = 50
        row(0).columns(0).size = 5      
    end

    items4 = m1.map {|i| [i["lan1"], i["lan2"], i["lan3"], i["diemgoctbkt"], i["diemtbkt"]]}
    mtable2 = pdf.make_table [["Điểm kiểm tra thường xuyên"]], :width => 110, :cell_style => {:align => :center, :valign => :center, :size => 7.5, :height => 20}
    mtable21 = pdf.make_table [["Lần 1", "Lần 2", "Lần 3", "TB Kiểm tra", "Quy điểm QT"]] + items4, :width => 110, :cell_style => {:align => :center, :valign => :center, :size => 7, :height => 20} do 
      (0..4).each do |i|
        row(0).columns(i).size = 5
        row(0).columns(i).height = 30
      end
    end
    
    items5 = m1.map {|i| [i["diemquatrinh"], i["note"]]}        
    mtable31 = pdf.make_table [["Tổng điểm QT", "Ghi chú"]] + items5, :cell_style => {:align => :center, :valign => :center, :size => 7, :height => 20}, :column_widths => {0 => 20, 1 => 39} do           
        (0..1).each do |i|
          row(0).columns(i).height = 50
          row(0).columns(i).size = 5        
        end            
        row(0).columns(1).size = 7.5
    end
    
    #mytable1 = pdf.make_table [[mytable0],[mytable01]]

    #mtable0 = pdf.make_table [["Điểm kiểm tra thường xuyên"]], :width => 80, :cell_style => {:align => :center, :size => 7}
    #mtable01 = pdf.make_table [["Lần 1", "Lần 2", "Lần 3", "TB Kiểm tra"]] + items3, :width => 80, :cell_style => {:align => :center, :size => 7}
    pdf.table [ 
      [
        [
          [mtable01],[mtable02]
        ],            
        [
          [mytable0],[mytable01]
        ],
        [
          [mtable11]
        ],
        [
          [mtable2],[mtable21]
        ],
        [
          [mtable31]
        ]
      ]
    ]                
    #pdf.start_new_page(:margin => 20) unless index == page_count
  end
  pdf.move_down 2
  d = DateTime.now
  
  #pdf.text "Duyệt #{object.sosvtucach} sinh viên được dự thi kết thúc học phần", :style => :italic, :size => 8
  pdf.table [["Duyệt #{object.sosvtucach} sinh viên được dự thi kết thúc học phần","",""],["","", "Hải phòng, ngày #{d.day} tháng #{d.month} năm #{d.year}"]], :cell_style => {:font_style => :italic, :size => 8, :borders => []}, :column_widths => {0 => 270, 1 => 270, 2 => 260} do 
    row(1).columns(2).padding_left = 20
  end
  pdf.move_down 2
  str = "Ghi chú:\n- Khi SV vắng đề nghị Thầy, Cô ghi cụ thể số tiết vắng.\nVí dụ V: có nghĩa SV vắng 3 tiết\n-Trước khi thi 7 ngày, giáo viên dạy môn học nộp bảng theo dõi cho Chủ nhiệm Bộm môn để duyệt tư cách dự thi cho sinh viên."
  pdf.table [[str, "CHỦ NHIỆM BỘ MÔN","GIÁO VIÊN PHỤ TRÁCH MÔN HỌC"]], :cell_style => {:borders => []}, :column_widths => {0 => 270, 1=> 270, 2 => 260} do 
    row(0).columns(0).font_style = :italic
    row(0).columns(0).size = 8
    row(0).columns(1).font_style = :bold
    row(0).columns(1).size = 12
    row(0).columns(2).font_style = :bold
    row(0).columns(2).size = 12
    row(0).columns(1).padding_left = 50
    #row(0).columns(2).padding_left = 0
  end
  pdf.repeat(:all) do 
    pdf.draw_text "QC07-B10", :at => [10, -10]
    #pdf.stamp "approved" 
  end
    #items.unshift ["Stt","Mã SV","Họ và tên","Ngày sinh",mytable1, "Điểm TH, TN, BTL, ĐA", mtable1, "Tổng điểm QT", "Ghi chú"]
    
            
    return pdf
  
  end

  def lichtrinh(tenant)
    sql = <<-eos  
            
select 'Tuần:' || tuan || tungay || denngay as tuan, noidung, sotiet, ngayday from (

select tt2.tuan, tt2.noidung, tt2.sotiet, tt2.ngayday, to_char(tt1.tu_ngay,'\nTừ: DD/MM/YYYY\n') as tungay
, to_char(tt1.den_ngay,'Đến: DD/MM/YYYY\n') as denngay
from t1.tuans as tt1
inner join (select tuan
, string_agg(noi_dung_day, '\r\n ') as noidung, sum(so_tiet_day_moi) as sotiet, 

replace(string_agg(to_char(ngay_day,'DD/MM/YYYY') ||
  case when ngay_day_moi is not null then
     '\r\n (' || to_char(ngay_day_moi,'DD/MM/YYYY') || ')'
  else
    ''
  end
 , '\n ') ,' ','')

as ngayday

from (select * from t1.lich_trinh_giang_days order by tuan, case ngay_day_moi is null when true then ngay_day else ngay_day_moi end) as tt
where lop_mon_hoc_id=#{object.id}
and noi_dung_day is not null
and destroyed_at is null
group by tuan
order by tuan)

as tt2 
on tt1.stt = tt2.tuan ) as ttt

    eos
    @lichs = ActiveRecord::Base.connection.execute(sql)
    
    pdf = Prawn::Document.new(:page_layout => :portrait,         
    :page_size => 'A4')
    #pdf.font "#{Rails.root}/app/assets/fonts/arial2.ttf"
    pdf.font_families.update(
      'Arial' => { :normal => Rails.root.join('app/assets/fonts/arial2.ttf').to_s,
                   :bold   => Rails.root.join('app/assets/fonts/arialbd.ttf').to_s,
                   :italic => Rails.root.join('app/assets/fonts/arialbi.ttf').to_s}                       
    )
    
    items = @lichs.map do |item|
      [
        item["tuan"],            
        item["noidung"].gsub('\r',''),
        item["sotiet"],
        item["ngayday"]
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
            pdf.font "Arial"
            dd = [["BỘ GIÁO DỤC VÀ ĐÀO TẠO","","CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM"],["TRƯỜNG ĐẠI HỌC DÂN LẬP HẢI PHÒNG","","Độc lập - Tự do - Hạnh phúc"]]
            pdf.table dd, :cell_style => {:borders => [], size: 8, :valign => :center}, :column_widths => {0 => 270, 1 => 4, 2 => 300}  do
              
              dd.count.times do |t|                    
                row(0).columns(0).padding_left = 50
                #row(0).columns(2).padding_left = 2
                row(1).columns(0).padding_left = 20
                row(1).columns(2).padding_left = 28
              end                                                      
              row(1).columns(0).font_style = :bold
              row(0).columns(2).font_style = :bold
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
        pdf.font "Arial"
        data = [
          ["Số tuần lễ", "","#{object.sotuan}","", "Môn học: #{object.ten_mon_hoc}"],
          ["Số tiết lý thuyết", "","...","", "CBGD phụ trách: #{object.ten_giang_vien}"],
          ["Số tiết BT,TN,TH,TKMH ","","...","", "Ngành: .................. Khóa: ..............."],
          ["Tổng số tiết","","#{object.khoi_luong}","", "Lớp: #{object.ma_lop} Học kỳ: #{tenant.hoc_ky} Năm học: #{tenant.nam_hoc}"]
        ]
        pdf.table data, :cell_style => {:borders => [], :size => 9}, :column_widths => {0 => 200, 2 => 30, 3 => 30} do               
          4.times do |t|
            row(t).columns(2).align = :center
          end
          row(0).columns(0).borders = [:top, :left]
          row(0).columns(1).borders = [:top]
          row(0).columns(2).borders = [:top, :right]
          row(0).columns(3).size = 11

          row(1).columns(0).borders = [:left]
          row(1).columns(1).borders = []
          row(1).columns(2).borders = [:right]
          row(1).columns(3).size = 11

          row(2).columns(0).borders = [:left]
          row(2).columns(1).borders = []
          row(2).columns(2).borders = [:right]
          row(2).columns(3).size = 11

          row(3).columns(0).borders = [:left, :bottom]
          row(3).columns(1).borders = [:bottom]
          row(3).columns(2).borders = [:right, :bottom]
          row(3).columns(3).size = 11
          #row(0).columns(0).font_style = :bold

        end

    end
    pdf.move_down(20)
    
    pdf.table(items, :header => true, :cell_style => {:size => 9}, :column_widths => {0 => 80,1 => 300, 2 => 40, 3 => 100}, :width => 520) do           
      items.count.times do |t|
        row(t).columns(0).font_style = :italic
        [0,2,3].each do |k|
          row(t).columns(k).valign = :center
          row(t).columns(k).align = :center
        end
        (0..3).each do |t|
          row(0).columns(t).font_style = :bold
          row(0).columns(t).align = :center
          row(0).columns(t).valign = :center
        end
      end
      row(0).columns(2).valign = :center
      row(0).columns(2).align = :center          
    end
    pdf.move_down(20)        
    pdf.text "Ghi chú: Lập thành 02 bản - Bộ môn và CBGD thực hiện - Kết thúc học kỳ nộp lại cho phòng ĐT", :size => 7
    d = DateTime.now
    footer = [["","", "Hải phòng, ngày #{d.day} tháng #{d.month} năm #{d.year}"],
    ["CHỦ NHIỆM BỘ MÔN","","GIẢNG VIÊN"]]
    pdf.table footer, :cell_style => {:borders => [], :size => 9}, :column_widths => {0 => 200, 1 => 100}, :width => 520 do 
      row(0).columns(2).align = :center
      row(0).columns(2).font_style = :italic
      row(1).columns(0).align = :center
      row(1).columns(2).align = :center
    end
    pdf.move_down(20)
    pdf.text "KÝ DUYỆT KẾ HOẠCH", :size => 7
    pdf.move_down(60)
    pdf.text "KÝ XÁC NHẬN ĐÃ HOÀN THÀNH KẾ HOẠCH"        , :size => 7
    
    pdf.repeat(:all) do 
      pdf.draw_text "QC07-B04/1", :at => [10, -10], :size => 8
    end
    
    return pdf
  end

  def phieudiem(tenant)    
    #svs = object.lop_mon_hoc_sinh_viens
    #tinchi = object.lop_mon_hoc_sinh_viens.where(lop_tin_chi: true)
    #nienche = (svs - tinchi)
    sql_nienche = <<-eos  
select ma_sinh_vien, ho_dem, ho, ten,  to_char(ngay_sinh,'DD/MM/YYYY' ) as "ngay_sinh", ma_lop_hanh_chinh, diem_chuyen_can, diem_thuc_hanh, diem_tbkt, diem_qua_trinh, lop_ghep  from t1.lop_mon_hoc_sinh_viens  where lop_mon_hoc_id = #{object.id}
and lop_tin_chi != true order by ten, ho_dem, ho, ngay_sinh 
    eos
    nienche = ActiveRecord::Base.connection.execute(sql_nienche).to_a
    nienche = nienche.map {|t| t and LSVCompare.new(t)}.sort
    sql_tinchi = <<-eos  
select ma_sinh_vien, ho_dem, ho, ten ,  to_char(ngay_sinh,'DD/MM/YYYY' ) as "ngay_sinh", ma_lop_hanh_chinh, diem_chuyen_can, diem_thuc_hanh, diem_tbkt, diem_qua_trinh, lop_ghep  from t1.lop_mon_hoc_sinh_viens  where lop_mon_hoc_id = #{object.id}
and lop_tin_chi = true order by ten, ho_dem,  ho,ngay_sinh 
    eos
    tinchi = ActiveRecord::Base.connection.execute(sql_tinchi).to_a
    tinchi = tinchi.map {|t| t and LSVCompare.new(t)}.sort
    if nienche.count > 0              
      tis2 = [nienche[0..27]] + (nienche[28..-1]||[]).each_slice(35).to_a                          
    end

    if tinchi.count > 0                
      tis = [tinchi[0..27]] + (tinchi[28..-1]||[]).each_slice(35).to_a          
    end
              
        
    if tis     
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
      tab2 = pdf.make_table [["PHIẾU ĐIỂM QUÁ TRÌNH"],["Lớp: #{object.ma_lop} Học kỳ: #{tenant.hoc_ky} Năm học: #{tenant.nam_hoc}\n\nMôn học: #{object.ten_mon_hoc}\n\nGiảng viên: #{object.ten_giang_vien} "]], :width => 210, :cell_style => {:borders => []} do 
        row(0).columns(0).font_style = :bold
        row(0).columns(0).padding_left = 20
        row(0).columns(0).valign = :center
        row(0).columns(0).size = 11
        row(1).columns(0).size = 9
      end

      pieces = [[img_path, ""]]
      pieces.each do |p|
      
        cursor = pdf.cursor 
        p.each_with_index do |v,j|
          pdf.bounding_box [cell_width*j, cursor], :height => row_height, :width => ( j == 0 ? cell_width : 460) do
            if j == 0
              pdf.image v, :width => 40
            else            
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
          item.msv,            
          item.hovaten,
          item.ngaysinh,
          item.ma_lop_hanh_chinh
        ]  
        end      
        tinchiitems2 = ti.each_with_index.map do |item,i|
           [              
          item.diem_chuyen_can,
          item.diem_thuc_hanh,
          item.diem_tbkt,
          item.diem_qua_trinh
        ]  
        end   
        tinchiitems3 = ti.each_with_index.map do |item,i|
          [              
            (item.lop_ghep == true and item.diem_chuyen_can == 0 ?  "GL, TC" : "") || (item.lop_ghep == true and item.diem_chuyen_can > 0 ? "GL" : "") || (!(item.lop_ghep == true) and item.diem_chuyen_can == 0 ? "TC" : "" )
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
        pdf.move_down 10
        prev = ti.count
      end
      pdf.move_down 1
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
      tab2 = pdf2.make_table [["PHIẾU ĐIỂM QUÁ TRÌNH"],["Lớp: #{object.ma_lop} Học kỳ: #{tenant.hoc_ky} Năm học: #{tenant.nam_hoc}\n\nMôn học: #{object.ten_mon_hoc}\n\nGiảng viên: #{object.ten_giang_vien} "]], :width => 210, :cell_style => {:borders => []} do 
        row(0).columns(0).font_style = :bold
        row(0).columns(0).padding_left = 20
        row(0).columns(0).valign = :center
        row(0).columns(0).size = 11
        row(1).columns(0).size = 9
      end

      pieces = [[img_path, ""]]
      pieces.each do |p|
      
        cursor = pdf2.cursor 
        p.each_with_index do |v,j|
          pdf2.bounding_box [cell_width*j, cursor], :height => row_height, :width => ( j == 0 ? cell_width : 460) do
            if j == 0
              pdf2.image v, :width => 40
            else            
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
          (index * prev2) + i+1,
          item.msv,            
          item.hovaten,
          item.ngaysinh,
          item.ma_lop_hanh_chinh
        ]  
        end      
        niencheitems2 = ti.each_with_index.map do |item,i|
           [              
          item.diem_chuyen_can,
          item.diem_thuc_hanh,
          item.diem_tbkt,
          item.diem_qua_trinh          
        ]  
        end   
        niencheitems3 = ti.each_with_index.map do |item,i|
          [              
            (item.lop_ghep == true and item.diem_chuyen_can == 0 ?  "GL, TC" : "") || (item.lop_ghep == true and item.diem_chuyen_can > 0 ? "GL" : "") || (!(item.lop_ghep == true) and item.diem_chuyen_can == 0 ? "TC" : "" )
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
        pdf2.move_down 10
        prev2 = ti.count
      end
      pdf2.move_down 1
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
    if stringio
      stringio.rewind    
      return stringio.sysread
    else
      return nil
    end
  end
end
