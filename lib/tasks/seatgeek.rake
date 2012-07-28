

require 'open-uri'
require 'json'


seatgeek = JSON.parse(open('http://api.seatgeek.com/2/events/?per_page=10').read)


seatgeek['events'].each do |listing|
  	a = Event.create
    a.name = listing['title'] 
	  a.save 
end