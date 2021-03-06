#!/usr/bin/env ruby

require 'rubygems'
require 'eventmachine'
require 'rest_client'

module GeoTransServer
  def post_init
    puts "-- someone connected to the echo server!"
  end

  def receive_data(data)
    puts "data: #{data}"
    data = data.split(',')
    if data[0] == '+RESP:GTRTL' or data[0] == '+RESP:GTTRI'
      imei = data[1]
      speed = data[6] #km/hr
      #heading = data[7]
      altitude = data[8] #m
      accuracy = data[9] # Enduro accuracy is a qualitative measure; see @TRACK protocol manual p. 13
      lon = data[10]
      lat = data[11]
      if lon != 0 and lat != 0 
        RestClient.post 'http://traveler.cocogeo.com/mobile/enduro/travel_fixes', 
                        'travel_fix[longitude]' => lon,
                        'travel_fix[latitude]' => lat,
                        'travel_fix[speed]' => speed,
                        'travel_fix[altitude]' => altitude,
                        'travel_fix[accuracy]' => accuracy,
                        'device[identification]' => imei
        puts 'travel_fix posted'
      end
    elsif data[0] == '+RESP:GTSOS'
      imei = data[1]
      RestClient.post 'http://traveler.cocogeo.com/mobile/enduro/questionnaire_trigger',
                      'device[identification]' => imei
      puts 'survey triggered'
    end
    
    #send_data "thanks!"
  end
end

EventMachine::run {
  EventMachine::open_datagram_socket('geogremlin.geog.ucsb.edu', 3000, GeoTransServer)
}