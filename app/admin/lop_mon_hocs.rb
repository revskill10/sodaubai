#encoding: UTF-8
ActiveAdmin.register LopMonHoc do
  #menu :if => proc{ can?(:manage, LopMonHoc) }     
  #controller.authorize_resource 

  menu :label => "Lớp môn học"
  index do 
    column :ma_lop
    column :ma_mon_hoc    
    column :giang_vien
    column :user
    default_actions
  end
  form do |f|

    f.inputs "Details" do 
      
      f.input :ma_lop, :as => :string, :label => "Mã lớp"
      f.input :ma_mon_hoc, :label => "Mã môn học"
      f.input :giang_vien, :label => "Mã giảng viên"      
      f.input :user, :label => "Trợ giảng"
    end

    f.actions
  end
end
