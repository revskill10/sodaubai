namespace :hpu do
  desc "TODO"
  task :load_tkbgiangvien => :environment do
  	@client = Savon.client(wsdl: "http://10.1.0.238:8082/HPUWebService.asmx?wsdl")
	response = @client.call(:tkb_theo_giai_doan)   	
	res_hash = response.body.to_hash		
	ls = res_hash[:tkb_theo_giai_doan_response][:tkb_theo_giai_doan_result][:diffgram][:document_element]
	ls = ls[:tkb_theo_giai_doan]
	GiangVien.delete_all
	TkbGiangVien.delete_all
	ls.each_with_index do |l,i|
		begin 			
			GiangVien.where(:ho_ten => l[:ten_giao_vien].strip, :ma_giang_vien => l[:ma_giao_vien].strip.downcase).first_or_create!
		rescue 
			puts i 
		end
		
		begin 
			TkbGiangVien.create!(hoc_ky: l[:hoc_ky].strip, ma_giang_vien: l[:ma_giao_vien].strip.downcase, ma_lop: l[:ma_lop].strip.downcase, ma_mon_hoc: l[:ma_mon_hoc].strip.downcase, ten_mon_hoc: l[:ten_mon_hoc].strip.downcase, nam_hoc: l[:nam_hoc].strip, ngay_bat_dau: l[:tu_ngay].new_offset(Rational(7, 24)), ngay_ket_thuc: l[:ngay_ket_thuc].new_offset(Rational(7, 24)), phong: (l[:ma_phong_hoc].strip if l.has_key?(:ma_phong_hoc) and l[:ma_phong_hoc].is_a?(String)), so_tiet: l[:so_tiet], so_tuan: l[:so_tuan_hoc], thu: l[:thu], tiet_bat_dau: l[:tiet_bat_dau], tuan_hoc_bat_dau: l[:tuan_hoc_bat_dau], ten_giang_vien: l[:ten_giao_vien].strip.downcase)		rescue puts i end
	end
  end
  task :update_days => :environment do 
  	TkbGiangVien.all.each do |tkb|
  		tkb.update_attributes(days: tkb.get_days)
  		tkb.save rescue puts "Error"
  	end
  end
  task :update_bt => :environment do 
  	TkbGiangVien.all.each do |tkb|
  		if tkb.ma_lop.include?("bt") then
  			tkb.loai = "bt"
  			tkb.ma_lop = tkb.ma_lop[0..tkb.ma_lop.length-5]
  			tkb.save rescue puts "Error #{tkb.ma_lop}"
  		end
  	end
  end
  task :load_sv => :environment do 
  	@client = Savon.client(wsdl: "http://10.1.0.238:8082/HPUWebService.asmx?wsdl")
  	response = @client.call(:sinh_vien_lop_mon_hoc)
  	res_hash = response.body.to_hash
  	ls = res_hash[:sinh_vien_lop_mon_hoc_response][:sinh_vien_lop_mon_hoc_result][:diffgram][:document_element]
	ls = ls[:sinh_vien_lop_mon_hoc]  
	SinhVien.delete_all	
	ls.each do |l|
		SinhVien.where(:ma_sinh_vien => l[:ma_sinh_vien].strip.downcase).first_or_create!
	end	
  end
  task :load_lopsv => :environment do  
  	@client = Savon.client(wsdl: "http://10.1.0.238:8082/HPUWebService.asmx?wsdl")
  	response = @client.call(:sinh_vien_lop_mon_hoc)
  	res_hash = response.body.to_hash
  	ls = res_hash[:sinh_vien_lop_mon_hoc_response][:sinh_vien_lop_mon_hoc_result][:diffgram][:document_element]
	ls = ls[:sinh_vien_lop_mon_hoc]  
	LopMonHocSinhVien.delete_all	
	ls.each do |l|
		LopMonHocSinhVien.create!(ma_lop: l[:ma_lop].strip, ma_mon_hoc: l[:ma_mon_hoc].strip.downcase, ma_sinh_vien: l[:ma_sinh_vien].strip.downcase, ma_lop_hanh_chinh: l[:ma_lop_hanh_chinh].strip.downcase, ten_mon_hoc: l[:ten_mon_hoc].strip)
	end	
  end
  task :update_loai_svlmh => :environment do 
  	LopMonHocSinhVien.all.each do |lop|  		
  		if lop.ma_lop.include?("bt") then
  			lop.loai = "bt"
  			lop.ma_lop = lop.ma_lop[0..lop.ma_lop.length-5]
  			lop.save rescue puts "Error #{lop.ma_lop}"
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
	ls.each do |l|		
		Tuan.create(stt: l[:tuan], tu_ngay: l[:tu_ngay].new_offset(Rational(7, 24)), den_ngay: l[:den_ngay].new_offset(Rational(7, 24)))
	end
  end

  task :load_lopmonhoc => :environment do 

  end

  task :load_all => :environment do 
  	Rake::Task["hpu:load_tuans"].invoke
  	Rake::Task["hpu:load_tkbgiangvien"].invoke
  	Rake::Task["hpu:update_days"].invoke
  	Rake::Task["hpu:load_lopsv"].invoke
  	Rake::Task["hpu:load_sv"].invoke  	
  end
end
