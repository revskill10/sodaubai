#encoding: UTF-8
ActiveAdmin.register TkbGiangVien do
  menu :label => "Thời khóa biểu"  

  index do    
    column :lop_mon_hoc 
    column :phong
    column :tuan_hoc_bat_dau
    column :so_tuan
    column :ngay_bat_dau
    column :ngay_ket_thuc
    column :so_tiet
    column :tiet_bat_dau
    column :thu    
    default_actions
  end
  form do |f|

    f.inputs "Details" do 
      
      f.input :lop_mon_hoc, :label => "Lớp môn học"
      f.input :phong
      f.input :tuan_hoc_bat_dau
      f.input :so_tuan
      f.input :ngay_bat_dau
      f.input :ngay_ket_thuc
      f.input :so_tiet
      f.input :tiet_bat_dau
      f.input :thu
    end

    f.actions
  end  
end
