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

		if planned_work.empty? != true
			planned_work.each {|item|
				# binding.pry
			puts item.css("b i").text #all caps headers
			item.css("b img").each { |img|
				puts img.attribute("alt").text #a single train icon alt text
			}
			puts item.css("b").children.last.text  #message about the trains
		}
		end
		# binding.pry

		browser.close
	end
end