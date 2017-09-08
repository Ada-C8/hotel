require 'csv'

module BookingSystem
  class Room
    attr_accessor :id, :cost

    def initialize(id, cost)
      @id = id
      @cost = cost
    end

    def self.all
      room_info = CSV.read('./support/rooms.csv', converters: :numeric)

      all_rooms = []
      room_info.each do |row|
        id = row[0]
        cost = row[1]
        all_rooms << Room.new(id, cost)
      end
      
      return all_rooms
    end

  end#of_Reservation_class
end#of_module_BookingSystem

#TESTING
# Hotel::Room.all #will access the list of all of the rooms in the hotel

#Jans-MBP:hotel janedrozo$ ruby lib/room.rb

#SPEC TESTING
#Jans-MBP:hotel janedrozo$ rake
