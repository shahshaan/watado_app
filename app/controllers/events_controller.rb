class EventsController < ApplicationController

def watado
  
end
 
 def import
   Event.destroy_all
   
   seatgeek = JSON.parse(open("http://api.seatgeek.com/2/events/?per_page=100").read)
   
   # add events from seatgeek.com to Event database
   
   seatgeek['events'].each do |listing|
     
      # if listing['venue']['state'] == "IL"
      
      a = Event.new
      a.name = listing['short_title']
      a.url = listing['venue']['url']
      a.category = listing['type']
      a.image = listing["performers"].first['image']
      # if a.image == nil
      #         a.image = listing["venue"].first['image']
      #       end
      a.location = "#{listing['venue']['address']} #{listing['venue']['city']}, #{listing['venue']['state']} #{listing['venue']['postal_code']}"
      a.venue = listing['venue']['name']
      a.zipcode = listing['venue']['postal_code']
      a.date = listing['datetime_local']
      a.start_time = listing['datetime_local']
      a.save
    end
    # end
    
    # delete and Event instance if it doesn't have an image
    Event.all.each do |event|
              if event.image == nil
                event.destroy
              end
            end
      
    redirect_to '/events'
 end
 
 # GET /events
 # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
              format.html # index.html.erb
              format.json { render json: @events }
            end
    
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
      
end
end

