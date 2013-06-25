namespace :hpu do
  desc "TODO"
  task :load_tkbgiangvien => :environment do
  	@client = Savon.client(wsdl: "http://10.1.0.238:8082/HPUWebService.asmx?wsdl")
	response = @client.call(:tkb_theo_giai_doan)   	
	res_hash = response.body.to_hash		
	ls = res_hash[:tkb_theo_giai_doan_response][:tkb_theo_giai_doan_result][:diffgram][:document_element]
	ls = ls[:tkb_theo_giai_doan]
	LopMonHoc.delete_all
	GiangVien.delete_all
	TkbGiangVien.delete_all
	puts "loading... giang_vien"
	ls.each_with_index do |l,i|
		
		GiangVien.where(:ho_ten => titleize(l[:ten_giao_vien].strip.downcase), :ma_giang_vien => l[:ma_giao_vien].strip.upcase).first_or_create!
						
		tkb = TkbGiangVien.create!(hoc_ky: l[:hoc_ky].strip, ma_giang_vien: l[:ma_giao_vien].strip.upcase, ma_lop: l[:ma_lop].strip.upcase, ma_mon_hoc: l[:ma_mon_hoc].strip.upcase, ten_mon_hoc: titleize(l[:ten_mon_hoc].strip.downcase), nam_hoc: l[:nam_hoc].strip, ngay_bat_dau: l[:tu_ngay].new_offset(Rational(7, 24)), ngay_ket_thuc: l[:ngay_ket_thuc].new_offset(Rational(7, 24)), phong: (l[:ma_phong_hoc].strip if l.has_key?(:ma_phong_hoc) and l[:ma_phong_hoc].is_a?(String)), so_tiet: l[:so_tiet], so_tuan: l[:so_tuan_hoc], thu: l[:thu], tiet_bat_dau: l[:tiet_bat_dau], tuan_hoc_bat_dau: l[:tuan_hoc_bat_dau], ten_giang_vien: titleize(l[:ten_giao_vien].strip.downcase))		

		tkb.update_attributes(days: tkb.get_days)
		ml = tkb.ma_lop
		if ml.include?("BT") then
  			tkb.loai = ml[ml.rindex("-")+1..ml.length-1]
  			tkb.ma_lop = tkb.ma_lop.tap {|s| s.slice!(tkb.loai)}  			
  		end
  		tkb.save rescue puts "Error #{tkb.ma_lop}"
  		
  		l = LopMonHoc.where(:ma_giang_vien => tkb.ma_giang_vien, :ma_lop => tkb.ma_lop, :ma_mon_hoc => tkb.ma_mon_hoc).first_or_create!
  		l.update_attributes(ten_giang_vien: tkb.ten_giang_vien, ten_mon_hoc: tkb.ten_mon_hoc, phong_hoc: tkb.phong, ngay_bat_dau: tkb.ngay_bat_dau, ngay_ket_thuc: tkb.ngay_ket_thuc, so_tuan_hoc: tkb.so_tuan)
  		l.save rescue puts "error #{l.id}"
		
  	end
  end
  task :load_lopsv => :environment do  
  	@client = Savon.client(wsdl: "http://10.1.0.238:8082/HPUWebService.asmx?wsdl")
  	response = @client.call(:sinh_vien_lop_mon_hoc)
  	res_hash = response.body.to_hash
  	ls = res_hash[:sinh_vien_lop_mon_hoc_response][:sinh_vien_lop_mon_hoc_result][:diffgram][:document_element]
	ls = ls[:sinh_vien_lop_mon_hoc]  
	SinhVien.delete_all
	LopMonHocSinhVien.delete_all	
	puts "loading... lopsv"
	ls.each do |l|
		SinhVien.where(:ma_sinh_vien => l[:ma_sinh_vien].strip.upcase).first_or_create!
		lop = LopMonHocSinhVien.create!(ma_lop: l[:ma_lop].strip, ma_mon_hoc: l[:ma_mon_hoc].strip.upcase, ma_sinh_vien: l[:ma_sinh_vien].strip.upcase, ma_lop_hanh_chinh: l[:ma_lop_hanh_chinh].strip.upcase, ten_mon_hoc: titleize(l[:ten_mon_hoc].strip.downcase))
		ml = lop.ma_lop
		if ml.include?("BT") then
  			lop.loai = ml[ml.rindex("-")+1..ml.length-1]
  			lop.ma_lop = lop.ma_lop.tap {|s| s.slice!(lop.loai)}  			
  			lop.save rescue puts "error #{lop.ma_lop}"
  		end

	end	
  end
  task :load_tuans => :environment do
  	@client = Savon.client(wsdl: "http://10.1.0.238:8082/HPUWebService.asmx?wsdl")
	response = @client.call(:thoi_gian_tuan)   	
	res_hash = response.body.to_hash		
	ls = res_hash[:thoi_gian_tuan_response][:thoi_gian_tuan_result][:diffgram][:document_element]
	ls = ls[:thoi_gian_tuan]
	Tuan.delete_all
	puts "loading... tuan"
	ls.each do |l|		
		Tuan.create(stt: l[:tuan], tu_ngay: l[:tu_ngay].new_offset(Rational(7, 24)), den_ngay: l[:den_ngay].new_offset(Rational(7, 24)))
	end
  end


  task :load_all => :environment do 
  	Rake::Task["hpu:load_tuans"].invoke # load tuans
  	Rake::Task["hpu:load_tkbgiangvien"].invoke  	# load tkb_giang_vien, giang_vien, lop_mon_hoc
  	Rake::Task["hpu:load_lopsv"].invoke # load lop_mon_hoc_sinh_vien, sinh_vien  	
  end

  task :update_gv => :environment do 
  	GiangVien.all.each do |gv|
  		gv.days = gv.get_days
      gv.save rescue puts "Error #{gv.ma_giang_vien}}"
  	end
  end
end
def titleize(str)
  str.split(" ").map(&:capitalize).join(" ")
end