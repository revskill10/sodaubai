#encoding: UTF-8
ActiveAdmin.register TkbGiangVien do
  menu :label => "Thời khóa biểu"
  filter :ma_lop
  index do 
    column :ma_lop
    column :ma_mon_hoc
    column :ten_mon_hoc
    column :ma_giang_vien
    
    default_actions
  end
  form do |f|

    f.inputs "Details" do 
      
      f.input :ma_lop, :as => :string, :label => "Mã lớp"
      f.input :ma_mon_hoc, :label => "Mã môn học"
      f.input :ma_giang_vien, :label => "Mã giảng viên"
      f.input :ten_mon_hoc,:label => "Tên môn học"
      f.input :so_tuan, :label => "Số tuần học"
      f.input :lop_mon_hoc, :label => "Lớp môn học"
    end

    f.actions
  end
end
