# encoding: utf-8
ActiveAdmin.register LopMonHoc do
  index do   	
    column :ma_lop
    column :ma_giang_vien
    column :ma_mon_hoc    
    default_actions
  end
  
  form do |f|
    f.inputs "Thời khóa biểu" do             
      f.input :ma_lop, :label => "Mã lớp"
      f.input :ma_mon_hoc, :label => "Mã môn học"
      f.input :ten_mon_hoc, :label => "Tên môn học"  
      f.input :ma_giang_vien, :label => "Mã giảng viên"            
      f.input :ten_giang_vien, :label => "Tên giảng viên"  
      f.input :user_id, :label => "Trợ giảng", :as => :select, :collection => User.all
    end
    f.actions
  end  
  controller do     
    def create
      params1 = params[:lop_mon_hoc]
      @lop_mon_hoc = LopMonHoc.where(ma_lop: params1[:ma_lop], ma_mon_hoc: params1[:ma_mon_hoc], ma_giang_vien: params1[:ma_giang_vien]).first
      unless @lop_mon_hoc
        @lop_mon_hoc = LopMonHoc.where(ma_lop: params1[:ma_lop], ma_mon_hoc: params1[:ma_mon_hoc], ma_giang_vien: params1[:ma_giang_vien]).create!
        @lop_mon_hoc.update_attributes(ten_mon_hoc: params1[:ten_mon_hoc],ten_giang_vien: params1[:ten_giang_vien])
      end
      if @lop_mon_hoc
        redirect_to admin_lop_mon_hoc_path(@lop_mon_hoc)
      end
    end
  end
end
