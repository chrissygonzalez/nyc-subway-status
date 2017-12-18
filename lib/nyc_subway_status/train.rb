class NycSubwayStatus::Train
	attr_accessor :name, :status, :url

	TRAINS = ["123", "456", "7", "ACE", "BDFM", "G", "JZ", "L", "NQR", "S", "SIR"]

	@@all = []

	def self.trains_constant
		TRAINS
	end

	def self.all
		@@all
	end

	def initialize(name, status, url = nil)
		@name = name
		@status = status
		@url = url
		@@all << self
	end

end