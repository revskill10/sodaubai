class DiemChiTietsController < ApplicationController
  before_filter :load_lop
  def index    
    
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens.order('ten asc')
    @group_diem = JSON.parse(@lop_mon_hoc.group_diem || {}.to_json) 
    respond_to do |format|      
      format.html do 
        if params[:loai] and params[:loai] == "2" then           
          render :nhom          
        else          
          render :index          
        end
      end# index.html.erb        
      format.json { head :no_content }
    end
  end


  def create
    # @diem_chi_tiet = DiemChiTiet.new(params[:diem_chi_tiet])
    @svs = @lop_mon_hoc.lop_mon_hoc_sinh_viens
    
    if @loai == 1 or @loai.nil?
      @msvs = params[:msv]
      @svs.each do   |sv|      
        if @msvs[sv.ma_sinh_vien]
          sv.diem_thuc_hanh = @msvs[sv.ma_sinh_vien][:thuchanh]
          sv.lan1 = @msvs[sv.ma_sinh_vien][:lan1]
          sv.lan2 = @msvs[sv.ma_sinh_vien][:lan2]
          sv.lan3 = @msvs[sv.ma_sinh_vien][:lan3]
          sv.lan4 = @msvs[sv.ma_sinh_vien][:lan4]
          sv.lan5 = @msvs[sv.ma_sinh_vien][:lan5]
          sv.diem_tbkt = sv.diemtbkt          
          sv.diem_chuyen_can ||= sv.diemcc  
          sv.diem_goc_tbkt = sv.diemtbkt1
          sv.diem_qua_trinh = sv.diemqt
          if sv.diem_chuyen_can == 0 
            sv.note = "TC"
          else
            sv.note = nil
          end
          sv.create_activity key: "lop_mon_hoc_sinh_vien.updatediemchitiet", params: {lan1: sv.lan1, lan2: sv.lan2, lan3: sv.lan3, lan4: sv.lan4, lan5: sv.lan5}, owner: current_user, recipient: sv.sinh_vien
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
