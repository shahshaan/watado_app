class Event < ActiveRecord::Base
  attr_accessible :category, :date, :end_time, :image, :location, :name, :start_time, :url, :venue, :zipcode
end
