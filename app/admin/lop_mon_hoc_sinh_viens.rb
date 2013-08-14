#encoding: UTF-8
ActiveAdmin.register LopMonHocSinhVien do
  #menu :if => proc{ can?(:manage, LopMonHoc) }     
  #controller.authorize_resource 

  menu :label => "Lớp môn học sinh viên"

  filter :ma_mon_hoc
  filter :ma_lop
  filter :ma_sinh_vien

  index do 
    column :ma_lop, :label => "Mã lớp"
    column :ma_lop_ghep, :label => "Mã lớp ghép"
    column :ma_mon_hoc, :label => "Mã môn học"    
    column :ma_sinh_vien, :label => "Mã sinh viên"    
    default_actions
  end
  form do |f|

    f.inputs "Details" do 
      f.input :ma_lop, :as => :string, :label => "Mã lớp"
      f.input :ma_lop_ghep, :as => :string, :label => "Mã lớp ghép"
      f.input :ma_mon_hoc, :label => "Mã môn học"      
      f.input :sinh_vien, :label => "Mã sinh viên"      
    end

    f.actions
  end
end
