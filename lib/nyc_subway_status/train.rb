class NycSubwayStatus::Train
	attr_accessor :name, :status, :url

	TRAINS = ["123", "456", "7", "ACE", "BDFM", "G", "JZ", "L", "NQR", "S", "SIR"]

	@@all = []

	def self.scrape_trains
		browser = Watir::Browser.new :chrome, headless: true
		browser.goto "http://alert.mta.info/"
		sleep(3)

		doc = Nokogiri::HTML.parse(browser.html)

		TRAINS.each_with_index { |line, index|
			train = self.new
			train.name = doc.css("#subwayDiv div img")[index].attribute("alt").text
			train.status = doc.css("##{line}").text
			train.url = doc.css("##{line} a").attribute("href").value if doc.css("##{line} a").empty? != true
			@@all << train
		}

		browser.close
	end

	def self.all
		@@all
	end

	def scrape_details
		browser = Watir::Browser.new :chrome, headless: true
		browser.goto "http://alert.mta.info/#{self.url}"
		sleep(3)

		doc = Nokogiri::HTML.parse(browser.html)
		planned_work = doc.css("#status_display .plannedWorkDetailLink")
		delay = doc.css("#status_display .TitleDelay")
		change = doc.css("#status_display .TitleServiceChange")
		# binding.pry
		if planned_work.empty? != true #maybe should break this out into its own method
			planned_work.each {|item|
				puts item.css("b i").text #all caps headers
				trains = []
				item.css("b img").each { |img|
					trains << train_name_trimmer(img.attribute("alt").text) #a single train icon alt text
				}
				# puts trains.join(", ")
				puts "#{trains.join(", ")} #{item.css("b").children.last.text.strip}"  #message about the trains
			}
		elsif delay.empty? != true
			puts "This train is delayed" #maybe this is unnecessary
			doc.css("#status_display").children.each { |child|
				# binding.pry
				if child.is_a? Nokogiri::XML::Text
					puts child.text.chomp
				elsif child.name == "img"
					puts train_name_trimmer(child.attribute("alt").text)
				elsif child.name == "strong"
					puts child.text
				else
					# binding.pry
				end
			}
		elsif change.empty? != true
			puts "Service Change"
			doc.css("#status_display").children.each { |child|
				if child.is_a? Nokogiri::XML::Text
					puts child.text.chomp
				elsif child.name == "img"
					puts train_name_trimmer(child.attribute("alt").text)
				else
					# binding.pry
				end
			}
		end

		browser.close
	end

	def train_name_trimmer(text)
		text[0]
	end
end