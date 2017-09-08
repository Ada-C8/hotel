require_relative 'availability'
require 'date'
require 'pry'
class Reservation
  # < Availability


# Have a list of all reservations method
  # Should this list all upcoming reservations?  Or all reservations ever?
  # Shovel all reservations ever into a hash which will output by default
  # Keyword argument lets you access reservations by date if you want

def initialize(room_id, startyear, startmonth, startday, endyear, endmonth, endday)
  if Availability.all_available_rooms(startyear, startmonth, startday, endyear, endmonth, endday).include?(room_id) == false
    # print Availability.all_available_rooms(startyear, startmonth, startday, endyear, endmonth, endday)
    raise ArgumentError.new("That room is not available for the given date range.")
  end

  checkin_date = Date.new(startyear,startmonth,startday)
  checkout_date = Date.new(endyear,endmonth,endday)

  wanteddate = checkin_date

  until wanteddate == checkout_date
    Availability.calendar.each do |days|
      days.each do |date, roominfo|
        if wanteddate == date
          roominfo.each do |rooms|
            rooms.each do |id, status|
              if id == room_id
                rooms[id] = :booked
              end
            end
          end
        end
      end
    end
    wanteddate += 1
  end
end




end # end of class
