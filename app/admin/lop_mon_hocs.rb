#encoding: UTF-8
ActiveAdmin.register LopMonHoc do
  form do |f|

    f.inputs "Details" do 
      
      f.input :ma_lop, :as => :string, :label => "Mã lớp"
      f.input :ma_mon_hoc, :disabled => true, :label => "Mã môn học"
      f.input :ten_mon_hoc, :disabled => true, :label => "Tên môn học"
      f.input :user, :label => "Trợ giảng"
    end

    f.actions
  end
end
