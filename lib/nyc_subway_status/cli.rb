class NycSubwayStatus::CLI

	def initialize
		NycSubwayStatus::Train.scrape_trains
	end

	def call
		list_trains
		menu
	end

	def list_trains
		puts ""
		puts "CURRENT MTA SERVICE STATUS"
		puts "--------------------------"
		# NycSubwayStatus::Train.scrape_trains
		NycSubwayStatus::Train.all.each_with_index {|line, index|
			puts "#{index + 1}. #{line.name} – #{line.status}"
		}
	end

	def menu
		puts ""
		puts ">> Enter a train number for details, 'list' to list all trains, or 'exit' to end this session."
		puts ""
		input = gets.chomp.downcase

		if input == "exit"
			say_bye
		elsif input == "list"
			list_trains
			menu
		elsif input.to_i < 1 || input.to_i > NycSubwayStatus::Train.all.length
			puts "Please enter a valid train number."
			menu
		elsif NycSubwayStatus::Train.all[input.to_i - 1].url == nil
			puts "The #{NycSubwayStatus::Train.all[input.to_i - 1].name} has good service! No details to report."
			menu
		else
			puts "Getting details for the #{NycSubwayStatus::Train.all[input.to_i - 1].name}..."
			puts ""
			NycSubwayStatus::Train.all[input.to_i - 1].scrape_details
			menu
		end
	end

	def say_bye
		puts "Bye!"
	end

end