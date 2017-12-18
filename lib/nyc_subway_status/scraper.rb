class NycSubwayStatus::Scraper
	def self.scrape_trains
		browser = Watir::Browser.new :chrome, headless: true
		browser.goto "http://alert.mta.info/"
		sleep(3)

		doc = Nokogiri::HTML.parse(browser.html)

		NycSubwayStatus::Train.trains_constant.each_with_index { |line, index|
			if doc.css("##{line} a").empty? != true
				train = NycSubwayStatus::Train.new(doc.css("#subwayDiv div img")[index].attribute("alt").text,
												   doc.css("##{line}").text,
												   doc.css("##{line} a").attribute("href").value)
			else
				train = NycSubwayStatus::Train.new(doc.css("#subwayDiv div img")[index].attribute("alt").text,
												   doc.css("##{line}").text)
			end
		}

		browser.close
	end

	def self.scrape_details(url)
		browser = Watir::Browser.new :chrome, headless: true
		browser.goto "http://alert.mta.info/#{url}"
		sleep(3)

		doc = Nokogiri::HTML.parse(browser.html)
		planned_work = doc.css("#status_display .plannedWorkDetailLink")
		delay = doc.css("#status_display .TitleDelay")
		change = doc.css("#status_display .TitleServiceChange")
		message = ""

		if change.empty? != true
			message = "SERVICE CHANGE\n#{mta_parser(doc.css("#status_display"))}\n"
		end

		if planned_work.empty? != true
			message = "#{mta_parser(doc.css("#status_display .plannedWorkDetailLink b"))}"
		end

		if delay.empty? != true
			message = "DELAYS\n#{mta_parser(doc.css("#status_display"))}"
		end

		browser.close
		message
	end

	def self.mta_parser(collection)
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

	def self.train_name_trimmer(text)
		text[0]
	end

	def self.message_formatter(text)
		m1 = text.gsub(/^\s/, "")
		m2 = m1.gsub(/[^,.\&\a-zA-Z0-9]/, " ")
		m2.gsub(/\s{2,}/, " ")
	end
end
