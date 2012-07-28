require 'csv'

# CSV.foreach(, :headers => true) do |row|
#   Event.create!(row.to_hash)
# end




desc "Import events from csv file"
task :import => [:environment] do

  file = "db/events.csv"

  CSV.foreach(file, :headers => true) do |row|
    a = Event.new
    a.location = row["location"]
    a.date = row["date"]
    a.start_time = row["start_time"]
    a.end_time = row["end_time"]
    a.image = row["image"]
    a.category = row["category"]
    a.name = row["name"]
    a.url = row["url"]
    a.venue = row["venue"]
    
    
    a.save
  end
  
end
  
  # 
  # Event.create{
  #   :location = row["locatiion"], 
  #   :date => row[2],
  #   :start_time => row[3],
  #   :end_time => row[4],
  #   :image => row[5],
  #   :category => row[6],
  #   :name => row[7],
  #   :url => row[8],
  #   :venue => row[9],
  # }