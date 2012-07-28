

require 'open-uri'
require 'json'


@seatgeek = JSON.parse(open('http://api.seatgeek.com/2/events/?per_page=100').read)


@seatgeek.each do |listing|
  a = Event.new
  a.name = listing['short_title']
  a.save
end