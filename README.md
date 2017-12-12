# NycSubwayStatus

NYC Subway Status is a gem that scrapes the MTA's Emergency Website (http://alert.mta.info/) using Watir and Nokogiri to display current status and details for New York City's subway system.

## Installation

Installation is as easy as typing

    $ gem install nyc_subway_status

then entering the command

	$ nyc-subway-status

## Usage

Enter nyc-subway-status on your command line to get the latest train status. Then enter the number of a train line, 'list' to list all trains, or 'exit' to shut it down.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chrissygonzalez/nyc_subway_status. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NycSubwayStatus project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/nyc_subway_status/blob/master/CODE_OF_CONDUCT.md).
