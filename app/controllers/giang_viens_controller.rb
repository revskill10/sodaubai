#encoding: utf-8

class GiangViensController < ApplicationController

  def show  	
  	@gv = GiangVien.where(ma_giang_vien: params[:id]).first
  	raise ActiveRecord::RecordNotFound unless @gv    
    @lichs = @gv.lich_trinh_giang_days.order('ngay_day, tuan')

    respond_to do |format|
      format.html
    end
  end

end