class DiemChiTietsController < ApplicationController
  before_filter :load_lop
  def index
    
    @svs = @lop_mon_hoc.get_sinh_viens
    respond_to do |format|
      format.html  do 
        # index.html.erb
        if @loai == 1 then 
          if request.headers['X-PJAX']
            render :index, :layout => false
          else
            render :index
          end
        else 
          if request.headers['X-PJAX']
            render :diemkiemtra, :layout => false
          else
            render :diemkiemtra
          end
        end
      end
      format.json { head :no_content }
    end
  end

  
  def create
    @diem_chi_tiet = DiemChiTiet.new(params[:diem_chi_tiet])

    respond_to do |format|
      if @diem_chi_tiet.save
        format.html do 
          if @loai == 1 then 
          if request.headers['X-PJAX']
            render :index, :layout => false
          else
            render :index
          end
        else 
          if request.headers['X-PJAX']
            render :diemkiemtra, :layout => false
          else
            render :diemkiemtra
          end
        end
        end
        format.json { render json: @diem_chi_tiet, status: :created, location: @diem_chi_tiet }
      else
        format.html do 
          if @loai == 1 then 
          if request.headers['X-PJAX']
            render :index, :layout => false
          else
            render :index
          end
        else 
          if request.headers['X-PJAX']
            render :diemkiemtra, :layout => false
          else
            render :diemkiemtra
          end
        end
        end
        format.json { render json: @diem_chi_tiet.errors, status: :unprocessable_entity }
      end
    end
  end

  protected
  def load_lop
    @lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])      
    @malop = @lop_mon_hoc.ma_lop
    @mamonhoc = @lop_mon_hoc.ma_mon_hoc
    @loai = params[:loai].to_i
    @dct = @lop_mon_hoc.diem_chi_tiets.diem_thuc_hanh if @loai==1
    @dct = @lop_mon_hoc.diem_chi_tiets.diem_kiem_tra if @loai==2
  end
end
