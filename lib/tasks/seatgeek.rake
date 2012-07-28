

require 'open-uri'
require 'json'


seatgeek = JSON.parse(open('http://api.seatgeek.com/2/events/?per_page=10').read)

Event.destroy_all

seatgeek['events'].each do |listing|
  	a = Event.new
    a.name = listing['title'] 
	  a.save 
end