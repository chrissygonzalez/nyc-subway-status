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

		if change.empty? != true
			puts "SERVICE CHANGE"
			puts "#{mta_parser(doc.css("#status_display"))}\n"
		end

		if planned_work.empty? != true
			puts mta_parser(doc.css("#status_display .plannedWorkDetailLink b"))
		end

		if delay.empty? != true
			puts "DELAYS"
			puts mta_parser(doc.css("#status_display"))
		end

		browser.close
	end

	def mta_parser(collection)
		message = ""

		collection.children.each { |child|
			if child.is_a? Nokogiri::XML::Text
				message += child.text
			elsif child.name == "img"
				message += " #{train_name_trimmer(child.attribute("alt").text)} "
			elsif child.name == "strong" || child.name == "b"
				message += " #{child.text} "
			elsif child.name == "i"
				message += "\n\n#{child.text}"
			elsif child.name == "br"
				message += "\n"
			elsif child.name == "p"
				puts mta_parser(child).strip
			end
		}

		message_formatter(message)
	end

	def train_name_trimmer(text)
		text[0]
	end

	def message_formatter(text)
		m1 = text.gsub(/^\s/, "")
		m2 = m1.gsub(/[^,.\&\a-zA-Z0-9]/, " ")
		m2.gsub(/\s{2,}/, " ")
	end
end