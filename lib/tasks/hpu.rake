require 'pg_tools'
namespace :hpu do
  desc "TODO"
  
  task :load_tkbgiangvien => :environment do
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false
  	@client = Savon.client(wsdl: "http://10.1.0.238:8082/HPUWebService.asmx?wsdl")
  	response = @client.call(:tkb_theo_giai_doan)   	
  	res_hash = response.body.to_hash		
  	ls = res_hash[:tkb_theo_giai_doan_response][:tkb_theo_giai_doan_result][:diffgram][:document_element]
  	ls = ls[:tkb_theo_giai_doan]
    GiangVien.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('giang_viens') 
    TkbGiangVien.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('tkb_giang_viens')	
  	puts "loading... giang_vien"
  	ls.each_with_index do |l,i|
		
  		GiangVien.where(:ho_ten => titleize(l[:ten_giao_vien].strip.downcase), :ma_giang_vien => l[:ma_giao_vien].strip.upcase).first_or_create!
  						
  		tkb = TkbGiangVien.create!( ma_giang_vien: l[:ma_giao_vien].strip.upcase, ma_lop: l[:ma_lop].strip.upcase, ma_mon_hoc: l[:ma_mon_hoc].strip.upcase, ten_mon_hoc: titleize(l[:ten_mon_hoc].strip.downcase), ngay_bat_dau: l[:tu_ngay].new_offset(Rational(7, 24)), ngay_ket_thuc: l[:ngay_ket_thuc].new_offset(Rational(7, 24)), phong: (l[:ma_phong_hoc].strip if l.has_key?(:ma_phong_hoc) and l[:ma_phong_hoc].is_a?(String)), so_tiet: l[:so_tiet], so_tuan: l[:so_tuan_hoc], thu: l[:thu], tiet_bat_dau: l[:tiet_bat_dau], tuan_hoc_bat_dau: l[:tuan_hoc_bat_dau], ten_giang_vien: titleize(l[:ten_giao_vien].strip.downcase))		
  		  		  		  				
  	end
  
    #Rake::Task["hpu:create_lopmonhoc"].invoke 
    #Rake::Task["hpu:update_tkb2"].invoke         
  end
  
  task :create_lopmonhoc => :environment do 
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false
    LopMonHoc.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('lop_mon_hocs') 
    TkbGiangVien.all.each do |tkb|
      l = LopMonHoc.where(:ma_giang_vien => tkb.ma_giang_vien, :ma_lop => tkb.ma_lop, :ma_mon_hoc => tkb.ma_mon_hoc).first_or_create!
      l.update_attributes(ten_giang_vien: tkb.ten_giang_vien, ten_mon_hoc: tkb.ten_mon_hoc, phong_hoc: tkb.phong, ngay_bat_dau: tkb.ngay_bat_dau, ngay_ket_thuc: tkb.ngay_ket_thuc, so_tuan_hoc: tkb.so_tuan)
      l.tkb_giang_viens << tkb
      l.save rescue puts "error #{l.id}"
    end
    
  end
  task :update_lopghep => :environment do 
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false
    tts = {}
    LopGhep.all.each do |lg|
      tts[[lg.ma_lop, lg.ma_mon_hoc]] = lg.ma_lop_ghep
    end
    LopMonHocSinhVien.all.each do |lmh|      
      lmh.ma_lop_ghep = lmh.ma_lop
      if tts[[lmh.ma_lop, lmh.ma_mon_hoc]] then         
        lmh.ma_lop_ghep = tts[[lmh.ma_lop, lmh.ma_mon_hoc]]        
      end
      lmh.save rescue puts "error"
    end
  end
  # cap nhat tkb set days
  task :update_tkb2 => :environment do 
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false
    TkbGiangVien.all.each do |tkb|
      tkb.update_attributes(days: tkb.get_days)
      tkb.save rescue puts "Error #{tkb.ma_lop}"
      #puts tkb.id if tkb.lop_mon_hoc.nil?
    end
  end
  
  
  
  task :load_sv => :environment do     
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false
    SinhVien.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('sinh_viens')
    # attr_accessible :gioi_tinh, :ho_dem, :lop_hc, :ma_he_dao_tao, :ma_khoa_hoc, :ma_nganh, :ma_sinh_vien, :ngay_sinh, :ten, :trang_thai, :ten_nganh

    @client = Savon.client(wsdl: "http://10.1.0.238:8082/HPUWebService.asmx?wsdl")
    response = @client.call(:sinh_vien_dang_hoc)
    res_hash = response.body.to_hash
    ls = res_hash[:sinh_vien_dang_hoc_response][:sinh_vien_dang_hoc_result][:diffgram][:document_element]
    ls = ls[:sinh_vien_dang_hoc]  
    puts "loading ... sinh viens"
    ls.each do |l|
      SinhVien.create!(
        gioi_tinh: (l[:gioi_tinh] if l[:gioi_tinh] and l[:gioi_tinh]),
        ho_dem: (titleize(l[:hodem].strip.downcase) if l[:hodem] and l[:hodem].is_a?(String)), 
        lop_hc: (l[:lop].strip.upcase if  l[:lop] and l[:lop].is_a?(String) ) ,
        ma_he_dao_tao: ( titleize(l[:ten_he_dao_tao].strip.downcase) if l[:ten_he_dao_tao] and l[:ten_he_dao_tao].is_a?(String) ),
        ma_khoa_hoc: ( titleize(l[:ten_khoa_hoc].strip.downcase) if l[:ten_khoa_hoc] and l[:ten_khoa_hoc].is_a?(String) ) ,
        ma_sinh_vien: (l[:ma_sinh_vien].strip.upcase if l[:ma_sinh_vien]),
        ngay_sinh: (l[:ngay_sinh].new_offset(Rational(7, 24)) if l[:ngay_sinh]),
        ten: ( titleize(l[:ten].strip.downcase) if l[:ten] and l[:ten].is_a?(String) ),
        trang_thai: (l[:trang_thai] if l[:trang_thai]),
        ten_nganh: ( titleize(l[:ten_nganh].strip.downcase) if l[:ten_nganh] and l[:ten_nganh].is_a?(String))
      )
    end
  end  
  task :load_tinchi => :environment do    
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false
    @client = Savon.client(wsdl: "http://10.1.0.238:8082/HPUWebService.asmx?wsdl")
    response = @client.call(:lop_hanh_chinh)    
    res_hash = response.body.to_hash    

    ls = res_hash[:lop_hanh_chinh_response][:lop_hanh_chinh_result][:diffgram][:document_element]
    ls = ls[:lop_hanh_chinh]
    
    tcs = {}
    ls.each do |l|
      ml = l[:ma_lop].strip.upcase
      tc = l[:dao_tao_theo_tin_chi]
      tcs[ml] = tc
    end
    SinhVien.all.each do |sv|
      sv.tin_chi = tcs[sv.lop_hc] || false
      sv.save!
    end
    LopMonHocSinhVien.all.each do |lsv|
      lsv.tin_chi = tcs[lsv.ma_lop_hanh_chinh] || false
      lsv.save!
    end
  end
  task :load_lopsv => :environment do  
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false
  	@client = Savon.client(wsdl: "http://10.1.0.238:8082/HPUWebService.asmx?wsdl")
  	response = @client.call(:lop_mon_hoc_sinh_vien_hk)
  	res_hash = response.body.to_hash
  	ls = res_hash[:lop_mon_hoc_sinh_vien_hk_response][:lop_mon_hoc_sinh_vien_hk_result][:diffgram][:document_element]
  	ls = ls[:lop_mon_hoc_sinh_vien_hk]  
  	#LopMonHocSinhVien.delete_all
    #ActiveRecord::Base.connection.reset_pk_sequence!('lop_mon_hoc_sinh_viens')
  	puts "loading... lopsv"
    #LopMonHocSinhVien.delete_all
    #ActiveRecord::Base.connection.reset_pk_sequence!('lop_mon_hoc_sinh_viens') 
  	ls.each do |l|  	
      hodem = titleize(l[:hodem].strip.downcase).split(" ").to_a
      ho = hodem[0] if hodem[0]
      ho_dem = hodem[1] if hodem[1]
      lop=LopMonHocSinhVien.where(ma_lop: l[:malop].strip.upcase, ma_lop_hanh_chinh: l[:ma_lop_hanh_chinh].strip.upcase, ma_mon_hoc: l[:ma_mon_hoc].strip.upcase, ma_sinh_vien: l[:ma_sinh_vien].strip.upcase).first_or_create!
  		lop.update_attributes(ten_mon_hoc: titleize(l[:ten_mon_hoc].strip.downcase), ho: ho,  ho_dem: ho_dem, ten: titleize(l[:ten].strip.downcase) ) 	
      lop.save!
  	end	
        
  end
 

  
  task :load_tuans => :environment do
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false
  	@client = Savon.client(wsdl: "http://10.1.0.238:8082/HPUWebService.asmx?wsdl")
  	response = @client.call(:thoi_gian_tuan)   	
  	res_hash = response.body.to_hash		
  	ls = res_hash[:thoi_gian_tuan_response][:thoi_gian_tuan_result][:diffgram][:document_element]
  	ls = ls[:thoi_gian_tuan]
  	Tuan.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('tuans') 
  	puts "loading... tuan"
  	ls.each do |l|		
  		Tuan.create(stt: l[:tuan], tu_ngay: l[:tu_ngay].new_offset(Rational(7, 24)), den_ngay: l[:den_ngay].new_offset(Rational(7, 24)))
  	end
  end
  task :load_lopghep => :environment do 
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false
    @client = Savon.client(wsdl: "http://10.1.0.238:8082/HPUWebService.asmx?wsdl")
    response = @client.call(:lop_ghep_hk)    
    res_hash = response.body.to_hash    
    ls = res_hash[:lop_ghep_hk_response][:lop_ghep_hk_result][:diffgram][:document_element]
    ls = ls[:t_lop_ghep_hk]
    LopGhep.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('lop_gheps') 
    puts "loading... lop ghep"
    ls.each do |l|
      LopGhep.create!(ma_lop_ghep: l[:ma_lop_ghep].strip, nam_hoc: l[:nam_hoc].strip,
        hoc_ky: l[:hoc_ky], ma_lop: l[:ma_lop].strip, ma_mon_hoc: l[:ma_mon_hoc].strip)
    end
  end

  task :load_all => :environment do 
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false

  	Rake::Task["hpu:load_tuans"].invoke # load tuans
    Rake::Task["hpu:load_lopghep"].invoke 
  	Rake::Task["hpu:load_tkbgiangvien"].invoke  	# load tkb_giang_vien, giang_vien, lop_mon_hoc
  	Rake::Task["hpu:load_lopsv"].invoke # load lop_mon_hoc_sinh_vien, sinh_vien    
    Rake::Task["hpu:update_lopghep"].invoke
    Rake::Task["hpu:update_tong_so_tiet"].invoke  
    Rake::Task["hpu:update_upcase"].invoke      
    Rake::Task["hpu:load_sv"].invoke
  end
  
  task :update_tong_so_tiet => :environment do 
#    tenant = Tenant.last
#    PgTools.set_search_path tenant.scheme, false
    LopMonHoc.all.each do |lop|
      lop.so_tiet = lop.tong_so_tiet
      lop.save! rescue "Save error #{lop.id}"
    end
  end
  task :update_upcase => :environment do 
    #tenant = Tenant.last
    #PgTools.set_search_path tenant.scheme, false
    LopGhep.all.each do |lgh|
      lgh.ma_lop = lgh.ma_lop.strip.upcase if lgh.ma_lop
      lgh.ma_mon_hoc = lgh.ma_mon_hoc.strip.upcase if lgh.ma_mon_hoc
      lgh.ma_lop_ghep = lgh.ma_lop_ghep.strip.upcase if lgh.ma_lop_ghep
      lgh.save!
    end
   LopMonHocSinhVien.all.each do |lmh|
      lmh.ma_lop_ghep = lmh.ma_lop_ghep.strip.upcase
      lmh.ma_lop = lmh.ma_lop.strip.upcase
      lmh.ma_mon_hoc = lmh.ma_mon_hoc.strip.upcase
      lmh.ma_sinh_vien = lmh.ma_sinh_vien.strip.upcase
      lmh.save!
    end


    LopMonHoc.all.each do |lop|
      lop.ma_giang_vien = lop.ma_giang_vien.strip.upcase
      lop.ma_lop = lop.ma_lop.strip.upcase
      lop.ma_mon_hoc = lop.ma_mon_hoc.strip.upcase
      lop.save! rescue "Save error #{lop.id}"
    end
    
    GiangVien.all.each do |gv|
      gv.ma_giang_vien = gv.ma_giang_vien.strip.upcase
      gv.save!
    end
    SinhVien.all.each do |sv|
      sv.ma_sinh_vien = sv.ma_sinh_vien.strip.upcase
      sv.save!
    end
    TkbGiangVien.all.each do |tkb|
      tkb.ma_lop = tkb.ma_lop.strip.upcase
      tkb.ma_mon_hoc = tkb.ma_mon_hoc.strip.upcase
      tkb.ma_giang_vien = tkb.ma_giang_vien.strip.upcase
      tkb.phong = tkb.phong.strip.upcase if tkb.phong
      tkb.save!
    end
    
  end
  task :test_gv => :environment do 
    
    GiangVien.all.each do |gupatev|
      puts gv.ma_giang_vien if gv.days = nil
    end
  end
  task :update_ho_ten => :environment do 
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false
    LopMonHocSinhVien.all.each do |lmh|
      sv = lmh.sinh_vien if lmh
      if sv 
        hodem = sv.ho_dem.split(" ").to_a
        ho = hodem[0]
        dem = hodem[1..-2] || ""
        lmh.ho = ho 
        lmh.ho_dem = dem
        lmh.ten = hodem[-1] || ""
      end
    end
  end
  task :get_null_lmh => :environment do 
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false
    res = []
    LopMonHoc.all.each do |l|
      if l.lop_mon_hoc_sinh_viens.count == 0 then 
        res << l.id
      end
    end
    File.open("D:/resultnull.txt","w") {|f| f.write(res)}
  end
  task :create_tenant => :environment do 
    t = Tenant.where(:nam_hoc => '2013-2014', :hoc_ky => 1, :scheme => 't1').first_or_create!         
  end
  task :update_data => :environment do 
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false
    DiemDanh.all.each do |dd|
      l = LopMonHoc.where(ma_lop: dd.ma_lop, ma_mon_hoc: dd.ma_mon_hoc, ma_giang_vien: dd.ma_giang_vien).first
      if l 
        dd.lop_mon_hoc = l
        dd.save!
      end
    end
    LichTrinhGiangDay.all.each do |dd|
      l = LopMonHoc.where(ma_lop: dd.ma_lop, ma_mon_hoc: dd.ma_mon_hoc, ma_giang_vien: dd.ma_giang_vien).first
      if l 
        dd.lop_mon_hoc = l
        dd.save!
      end
    end    
  end
  task :update_lich_giang_day_for_diem_danh => :environment do 
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false

    DiemDanh.all.each do |dd|
      lich = LichTrinhGiangDay.where(lop_mon_hoc_id: dd.lop_mon_hoc.id, ngay_day: dd.ngay_vang).first_or_create!
      if lich 
        dd.lich_trinh_giang_day = lich
        dd.save! rescue puts "error #{dd.id}"
      end
    end
  end

  task :update_lop_for_lmhsv => :environment do 
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false

    LopMonHocSinhVien.all.each do |lmh|
      lop = LopMonHoc.where(ma_lop: lmh.ma_lop_ghep, ma_mon_hoc: lmh.ma_mon_hoc).first
      if lop 
        lmh.lop_mon_hoc = lop
        lmh.save! rescue puts "error #{lmh.id}"
      end
    end
  end

  task :update_mon_hoc => :environment do 
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false
    LopMonHoc.all.each do |lop|
      MonHoc.where(ma_mon_hoc: lop.ma_mon_hoc, ten_mon_hoc: lop.ten_mon_hoc).first_or_create!
    end
  end


#step 1

  task :update_lop_mon_for_lich_giang_day => :environment do 
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false
    LichTrinhGiangDay.all.each do |l|
      l.ma_lop  = l.lop_mon_hoc.ma_lop
      l.ma_mon_hoc = l.lop_mon_hoc.ma_mon_hoc
      l.save!
    end
  end
# step 2: run update tkb task

#step 3: update back lich giang day
  task :update_back_lich_giang_day => :environment do 
    tenant = Tenant.last
    PgTools.set_search_path tenant.scheme, false
    LichTrinhGiangDay.all.each do |l|
      lop = LopMonHoc.where(ma_lop: l.ma_lop, ma_mon_hoc: l.ma_mon_hoc).first
      if lop 
        l.lop_mon_hoc = lop 
        l.save!
      end
    end
  end


end
def titleize(str)
  str.split(" ").map(&:capitalize).join(" ").gsub("Ii","II")
end