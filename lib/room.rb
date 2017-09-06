require 'csv'
require 'awesome_print'

#info_hash{id: 1, cost: 200}
module Hotel
  class Room
    attr_accessor :id, :cost

    def initialize(id, cost)
      @id = id
      @cost = cost
      #@all_rooms = [] this way can't work
    end

    def self.all
      room_info = CSV.read('./support/rooms.csv')

      all_rooms = []
      room_info.each do |row|
        id = row[0]
        cost = row[1]
        all_rooms << Room.new(id, cost)
      end

      return all_rooms
    end

  end#of_Room_class
end#of_module_Hotel

#TESTING
#ap Hotel::Room.all #will access the list of all of the rooms in the hotel

#Jans-MBP:hotel janedrozo$ ruby lib/room.rb

#SPEC TESTING
#Jans-MBP:hotel janedrozo$ rake
