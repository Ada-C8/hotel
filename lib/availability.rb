require_relative 'rooms'
require 'date'
require 'pry'

# Recognize that a :blocked room should be able to be booked, but only by certain people

# Allow people to reserve a certain room ID

# Be able to return a collection of open rooms on any given date or for any given date block
# Be able to return a collection of reserved rooms on any given date or for any given date block
# Be able to return a collection of blocked rooms on any given date or for any given date block

class Availability
attr_accessor :calendar
HOTEL = Hotel.new

  def self.calendar
    calendar = []

    date = Date.today
    roominfo = []

    HOTEL.rooms.each do |room|
      id = room.id
      status = room.status
      roominfo << {id => status}
    end

    366.times do
      calendar << {date => roominfo}
      date = date + 1
    end

    return calendar

  end

  def self.all_available_rooms(startyear, startmonth, startday, endyear, endmonth, endday)
    checkin_date = Date.new(startyear,startmonth,startday)
    checkout_date = Date.new(endyear,endmonth,endday)
    openrooms = []

    wanteddate = checkin_date

    until wanteddate == checkout_date
      self.calendar.each do |days|
        days.each do |date, roominfo|
          if wanteddate == date
            roominfo.each do |rooms|
              rooms.each do |id, status|

                if status == :available
                  openrooms << id
                end
                # binding.pry
              end

            end
          end
        end
      end
      wanteddate += 1
    end

    total_stay = (checkout_date - checkin_date).to_i
    finalrooms = []
    (1..20).each do |id|
      if openrooms.count(id) == total_stay
        finalrooms << id
      end
    end
    return finalrooms
  end


end #end of class

Availability.all_available_rooms(2017, 9, 8, 2017, 9, 9)
