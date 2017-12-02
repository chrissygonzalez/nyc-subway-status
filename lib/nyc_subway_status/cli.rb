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
		# trs = browser.trs
		sleep(5)
		doc = Nokogiri::HTML.parse(browser.html)
		binding.pry


		train123name = doc.css("#subwayDiv td")[1].children[0].attribute("alt").value
		train123status = doc.css("#subwayDiv td")[2].children.children.text

		doc.css("#subwayDiv td").click
		binding.pry
		# doc.css("#subwayDiv td")[3].children[0].attribute("alt").value is 456 Subway
		# 1 is 123, 3 is 456, 5 is 7...
		# doc.css("#subwayDiv td")[6].children.children.text is Good Service for the 7
		# if planned work, on new page, need content within <div id="status-contents">
	end
end