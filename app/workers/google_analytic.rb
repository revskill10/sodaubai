class GoogleAnalytic
	@queue = :ga

	def self.perform(obj)
		obj = JSON.parse(obj)
		puts "logging #{obj['category']} - #{obj['action']} - #{obj['label']} - #{obj['value']}"
		Gabba::Gabba.new("UA-45746322-1", "qlgd.hpu.edu.vn").event(obj['category'], obj['action'], obj['label'], obj['value'], true)
	end
end