class NycSubwayStatus::CLI

	def call
		list_trains
		menu
	end

	def list_trains
		puts "CURRENT MTA SERVICE STATUS"
		puts "--------------------------"
		NycSubwayStatus::Train.scrape_trains
		NycSubwayStatus::Train.all.each_with_index {|line, index|
			puts "#{index + 1}. #{line.name} – #{line.status}"
		}
	end

	def menu
		puts "Enter the number of line you'd like to know more about, or enter exit to end this session."
		input = gets.chomp
		puts "You entered #{input}."
		if input == "exit"
			say_bye
		else
			menu
		end
	end

	def say_bye
		puts "Bye!"
	end

end