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

		if doc.css("#status_display .plannedWorkDetailLink").empty? != true
			doc.css("#status_display .plannedWorkDetailLink b i").text #all caps headers
			doc.css("#status_display .plannedWorkDetailLink b")[1].children[0].text #also all caps headers
			doc.css("#status_display .plannedWorkDetailLink b")[1].children.css("img") #array of train icon images
			doc.css("#status_display .plannedWorkDetailLink b")[1].children.css("img")[0].attribute("alt").text #a single train icon alt text
			doc.css("#status_display .plannedWorkDetailLink b")[1].children.last #message about the trains

			doc.css("#status_display .plannedWorkDetailLink img") #need to iterate through however many there are?
		end
		binding.pry

		browser.close
	end
end