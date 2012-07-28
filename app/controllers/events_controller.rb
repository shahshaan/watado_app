
require 'open-uri'
require 'json'

class EventsController < ApplicationController
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
    
  @seatgeek = JSON.parse(open('http://api.seatgeek.com/2/events/?per_page=10').read)

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
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
  
  def import
    Event.destroy_all
    
    seatgeek = JSON.parse(open('http://api.seatgeek.com/2/events/?per_page=5').read)
    
    seatgeek['events'].each do |listing|
      a = Event.new
      a.name = listing['short_title']
      # a.name = listing["performers"].first['short_name']
      a.url = listing['venue']['url']
      a.category = listing['type']
      a.image = listing["performers"].first['image']
      # a.location = listing['venue']['address'] +" " listing['venue']['city'] + ","
      a.location = "#{listing['venue']['address']} #{listing['venue']['city']}, #{listing['venue']['state']} #{listing['venue']['postal_code']}"
    	a.venue = listing['venue']['name']
    	a.save
    end
    
    redirect_to '/events'
  end

end
