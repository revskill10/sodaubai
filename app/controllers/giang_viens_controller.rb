#encoding: utf-8

class GiangViensController < ApplicationController

  def show  	
  	@gv = GiangVien.where(ma_giang_vien: params[:id]).first
  	@id = params[:id]
  	raise ActiveRecord::RecordNotFound unless @gv    
    @lichs = @gv.lich_trinh_giang_days.order('ngay_day, tuan')    
    QC.enqueue "GoogleAnalytic.perform", {:category => "Giangvien", :action => "show", :label => "#{current_user.username}", :value => "1"}.to_json
    respond_to do |format|
      format.html
    end
  end

end