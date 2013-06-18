require 'date'
namespace :hpu do
  desc "TODO"
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

end
