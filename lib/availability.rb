require_relative 'rooms'
require 'date'
require 'pry'


# When the first day of a reservation hits, an individual room room's status should be changed to :booked
# When the last day of a reservation hits, a room's status should  automatically change back to :available
# Recognize that a :blocked room should be able to be booked, but only by certain people

# Allow people to reserve a certain room ID

# Be able to return a collection of open rooms on any given date or for any given date block
# Be able to return a collection of reserved rooms on any given date or for any given date block
# Be able to return a collection of blocked rooms on any given date or for any given date block

class Availability
attr_accessor :calendar

  def initialize
    hotel = Hotel.new
    @calendar = []
    # Everyday for the next year, I want a collection of dates, and for each date object, I want to see an attached collection of each room in the hotel & its status

    date = Date.today
    roominfo = []

    # index = 0
    # hotel.rooms.each do |room|
    #   roominfo << {hotel.rooms[index].id => hotel.rooms[index].status}
    #   index += 1
    # end

    hotel.rooms.each do |room|
      roominfo << {:id => room.id, :status => room.status}
    end

    366.times do
      @calendar << {:date => date, :all_room_status => roominfo}
      date = date + 1
    end

  end

  def all_available_rooms(year, month, day)
    input_date = Date.new(year,month,day)
    openrooms = []
    @calendar.each do |dates|
      dates.each do |datekey, datevalue|
        if input_date == datevalue
          dates[:all_room_status].each do |roominfo|
            roominfo.each do |id, status|
              if roominfo[:status] == :available
                openrooms << roominfo[:id]
              end
            end
          end
        end
      end
    end
    return openrooms
  end

end #end of class

# all_availability = Availability.new
# all_availability.all_available_rooms(2017,9,8)
