class DiemChiTietsController < ApplicationController
  before_filter :load_lop
  def index    
    authorize! :quanly, @lop_mon_hoc if current_user.is_a?(GiangVien)
    authorize! :read, @lop_mon_hoc if current_user.is_a?(SinhVien)    
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens.order('ten asc')
    @group_diem = JSON.parse(@lop_mon_hoc.group_diem || {}.to_json)     
    QC.enqueue "GoogleAnalytic.perform", {:category => "Diemchitiet", :action => "index", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|      
      format.html do 
        if params[:loai] and params[:loai] == "2" then        
          if @lop_mon_hoc.da_day_xong   
            render :nhom2
          else
            render :nhom
          end
        else
          if @lop_mon_hoc.da_day_xong
            render :index2
          else
            render :index
          end
        end
      end     
      format.json { head :no_content }
    end
  end


  def create
    # @diem_chi_tiet = DiemChiTiet.new(params[:diem_chi_tiet])
    authorize! :manage, @lop_mon_hoc
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    if @loai == 1 or @loai.nil?
      @msvs = params[:msv]
      @svs.each do   |sv|      
        if @msvs[sv.ma_sinh_vien]
          test = (@msvs[sv.ma_sinh_vien][:thuchanh].present? or @msvs[sv.ma_sinh_vien][:lan1].present? or @msvs[sv.ma_sinh_vien][:lan2].present? or @msvs[sv.ma_sinh_vien][:lan3].present? or @msvs[sv.ma_sinh_vien][:lan4].present? or @msvs[sv.ma_sinh_vien][:lan5].present?)
          sv.diem_thuc_hanh = @msvs[sv.ma_sinh_vien][:thuchanh].to_f if @msvs[sv.ma_sinh_vien][:thuchanh].present? and @msvs[sv.ma_sinh_vien][:thuchanh].to_f >= 0 and @msvs[sv.ma_sinh_vien][:thuchanh].to_f <= 10
          sv.lan1 = @msvs[sv.ma_sinh_vien][:lan1].to_f if @msvs[sv.ma_sinh_vien][:lan1].present? and @msvs[sv.ma_sinh_vien][:lan1].to_f >=0 and @msvs[sv.ma_sinh_vien][:lan1].to_f <= 10
          sv.lan2 = @msvs[sv.ma_sinh_vien][:lan2].to_f if @msvs[sv.ma_sinh_vien][:lan2].present? and @msvs[sv.ma_sinh_vien][:lan2].to_f >= 0 and @msvs[sv.ma_sinh_vien][:lan2].to_f <= 10
          sv.lan3 = @msvs[sv.ma_sinh_vien][:lan3].to_f if @msvs[sv.ma_sinh_vien][:lan3].present? and @msvs[sv.ma_sinh_vien][:lan3].to_f >= 0 and @msvs[sv.ma_sinh_vien][:lan3].to_f <= 10
          sv.lan4 = @msvs[sv.ma_sinh_vien][:lan4].to_f if @msvs[sv.ma_sinh_vien][:lan4].present? and @msvs[sv.ma_sinh_vien][:lan4].to_f >= 0 and @msvs[sv.ma_sinh_vien][:lan4].to_f <= 10
          sv.lan5 = @msvs[sv.ma_sinh_vien][:lan5].to_f if @msvs[sv.ma_sinh_vien][:lan5].present? and @msvs[sv.ma_sinh_vien][:lan5].to_f >= 0 and @msvs[sv.ma_sinh_vien][:lan5].to_f <= 10          
          sv.diem_chuyen_can ||= sv.diemcc  
          sv.diem_goc_tbkt = sv.diemtbkt1
          sv.diem_tbkt = sv.diemtbkt          
          sv.diem_qua_trinh = sv.diemqt
          if sv.diem_chuyen_can == 0 
            sv.note = "TC"
          else
            sv.note = nil
          end
          sv.create_activity key: "lop_mon_hoc_sinh_vien.updatediemchitiet", params: {lan1: sv.lan1, lan2: sv.lan2, lan3: sv.lan3, lan4: sv.lan4, lan5: sv.lan5}, owner: current_user, recipient: sv.sinh_vien if test == true
          sv.save! rescue puts "error"
        end
      end
    elsif @loai.to_s == "2"
      @lop_mon_hoc.group_diem = params[:group].to_json
      @lop_mon_hoc.save! rescue "Error ggrouporup diem"
      if @lop_mon_hoc.group_diem
        temp = JSON.parse(@lop_mon_hoc.group_diem) 
        @svs.each do |sv|        
          diem_nhom = temp[sv.group_id.to_s]      
          sv.diem_thuc_hanh = diem_nhom          
          sv.diem_goc_tbkt = sv.diemtbkt1
          sv.diem_chuyen_can ||= sv.diemcc
          sv.diem_qua_trinh = sv.diemqt
          if sv.diem_chuyen_can == 0 
            sv.note = "TC"
          else
            sv.note = nil
          end
          sv.create_activity key: "lop_mon_hoc_sinh_vien.updatediemthuchanh", params: {diemthuchanh: sv.diem_thuc_hanh}, owner: current_user, recipient: sv.sinh_vien
          sv.save! rescue "error update nhom"
        end
      end
    end    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Diemchitiet", :action => "create", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|      
        format.js      
    end
  end

  protected
  def load_lop
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])      
    @malop = @lop_mon_hoc.ma_lop
    @mamonhoc = @lop_mon_hoc.ma_mon_hoc    
    
    @loai = params[:loai]
  end
end
