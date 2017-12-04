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

	def new_call(subway_url)
		browser = Watir::Browser.new :chrome, headless: true
		browser.goto subway_url
		sleep(3)

		doc = Nokogiri::HTML.parse(browser.html)

		train123name = doc.css("#subwayDiv div img")[0].attribute("alt").text
		train123status = doc.css("#123").text
		train123link = doc.css("#123 a").attribute("href").value if doc.css("#123 a").empty? != true

		train456name = doc.css("#subwayDiv div img")[1].attribute("alt").text
		train456status = doc.css("#456").text
		train456link = doc.css("#456 a").attribute("href").value if doc.css("#456 a").empty? != true

		train7name = doc.css("#subwayDiv div img")[2].attribute("alt").text
		train7status = doc.css("#7").text
		train7link = doc.css("#7 a").attribute("href").value if doc.css("#7 a").empty? != true

		trainACEname = doc.css("#subwayDiv div img")[3].attribute("alt").text
		trainACEstatus = doc.css("#ACE").text
		trainACElink = doc.css("#ACE a").attribute("href").value if doc.css("#ACE a").empty? != true

		trainBDFMname = doc.css("#subwayDiv div img")[4].attribute("alt").text
		trainBDFMstatus = doc.css("#BDFM").text
		trainBDFMlink = doc.css("#BDFM a").attribute("href").value if doc.css("#BDFM a").empty? != true

		trainGname = doc.css("#subwayDiv div img")[5].attribute("alt").text
		trainGstatus = doc.css("#G").text
		trainGlink = doc.css("#G a").attribute("href").value if doc.css("#G a").empty? != true

		trainJZname = doc.css("#subwayDiv div img")[6].attribute("alt").text
		trainJZstatus = doc.css("#JZ").text
		trainJZlink = doc.css("#JZ a").attribute("href").value if doc.css("#JZ a").empty? != true

		trainLname = doc.css("#subwayDiv div img")[7].attribute("alt").text
		trainLstatus = doc.css("#L").text
		trainLlink = doc.css("#L a").attribute("href").value if doc.css("#L a").empty? != true

		trainNQRWname = doc.css("#subwayDiv div img")[8].attribute("alt").text
		trainNQRWstatus = doc.css("#NQRW").text
		trainNQRWlink = doc.css("#NQRW a").attribute("href").value if doc.css("#NQRW a").empty? != true

		trainSname = doc.css("#subwayDiv div img")[9].attribute("alt").text
		trainSstatus = doc.css("#S").text
		trainSlink = doc.css("#S a").attribute("href").value if doc.css("#S a").empty? != true

		trainSIRname = doc.css("#subwayDiv div img")[10].attribute("alt").text
		trainSIRstatus = doc.css("#SIR").text
		trainSIRlink = doc.css("#SIR a").attribute("href").value if doc.css("#SIR a").empty? != true

		binding.pry
	end
end