require 'date'
require 'json'

class BuoihocController < ApplicationController
  before_filter :load_lop, :only => [:show, :diemdanh]
  def show
  	authorize! :read, @lop_mon_hoc
  	

    if request.headers['X-PJAX']
      render :layout => false
    end
  end
  
  def diemdanh
    msvs = []
    params.each do |k,v|
      if k.to_s.include?("msv") then 
        msvs << {:msv => k.to_s, :vang => v.to_i}
      end
    end
    msvs.each do |ms|
      dds = DiemDanh.thongtin(@malop,@mamonhoc,ms[:msv], @ngay)
      if dds.empty? then 
        DiemDanh.create(ma_sinh_vien: ms[:msv], ma_lop: @malop, ma_mon_hoc: @mamonhoc, ngay_vang: @ngay, so_tiet_vang: ms[:vang])
      else
        dds.first.update_attributes(so_tiet_vang: ms[:vang])
      end
    end

    respond_to do |format|
      format.js
    end
  end

  protected
  def load_lop
  	@lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])  	
    @ngay = DateTime.strptime(params[:id], "%Y-%m-%d-%H-%M")
    @malop = @lop_mon_hoc.ma_lop
    @mamonhoc = @lop_mon_hoc.ma_mon_hoc
    @svs = JSON.parse(@lop_mon_hoc.dssv)
  end
end
