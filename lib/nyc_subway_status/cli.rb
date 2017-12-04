class NycSubwayStatus::CLI

	def call
		list_trains
	end

	def list_trains
		puts "Scraping trains!"
		NycSubwayStatus::Train.scrape_trains
	end

	def say_bye
	end

end