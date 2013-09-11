class GvLogger
	@queue = :gvlogger

	def self.perform(obj)
		puts obj
	end
end