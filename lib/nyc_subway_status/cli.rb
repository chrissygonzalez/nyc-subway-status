class NycSubwayStatus::CLI

	def call
		 puts <<-eos
Here's the current subway status:
[1, 2, 3] 		Planned Work
[4, 5, 6] 		Planned Work
[7] 			Good Service
[A, C, E] 		Planned Work
[B, D, F, M] 		Planned Work
[G]			Good Service
[J, Z]			Good Service
[L]		 	Planned Work
[N, Q, R]		Planned Work
[S]			Planned Work
[Staten Island Railway]	Planned Work
eos
	end

	def new_call(subway_url)
		browser = Watir::Browser.new
		browser.goto subway_url
		doc = Nokogiri::HTML.parse(browser.html)
		binding.pry
		# puts doc.css("#subwayDiv img.subwayIcon_123").attribute("alt").text
		# puts doc.css("div#123 a").text
		#doc.css("#subwayDiv div div").children[0]
		#doc.css("#subwayDiv div").children[3]
		#doc.css(".subwayCategory")[1]
	end
end