#encoding: UTF-8
ActiveAdmin.register TkbGiangVien do
  belongs_to :lop_mon_hoc
  form do |f|
    f.inputs "Thời khóa biểu" do             
      f.input :tuan_hoc_bat_dau, :label => "Tuần học bắt đầu", :as => :select, :collection => Tuan.pluck(:stt)
      f.input :so_tuan, :label => "Số tuần"
      f.input :thu, :label => "Thứ", :as => :select, :collection => TkbGiangVien::THU2.map {|k,v| [v,k]}
      f.input :so_tiet, :label => "Số tiết"
      f.input :phong, :label => "Phòng học", :as => :select, :collection => LopMonHoc.pluck(:phong_hoc).uniq
      f.input :tiet_bat_dau, :label => "Tiết bắt đầu"
    end
    f.actions
  end
  index do 
    column :tuan_hoc_bat_dau
    column :so_tuan
    column :thu
    column :so_tiet
    column :phong
    column :tiet_bat_dau
    default_actions
  end
  controller do     
    def create
      @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])
      @tkb_giang_vien = @lop_mon_hoc.tkb_giang_viens.create!(params[:tkb_giang_vien])
      if @tkb_giang_vien
        redirect_to admin_lop_mon_hoc_tkb_giang_vien_path(@lop_mon_hoc, @tkb_giang_vien)
      else
        redirect_to admin_lop_mon_hoc_tkb_giang_viens_path(@lop_mon_hoc)
      end
    end
  end
end
