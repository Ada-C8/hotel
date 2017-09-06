require_relative 'availability'
require 'date'
require 'pry'
class Reservation < Availability




# A reservation takes an individual instance of a room object and changes its status for the future, and also outputs cost-related information



# Have a list of all reservations method
  # Should this list all upcoming reservations?  Or all reservations ever?
  # Shovel all reservations ever into a hash which will output by default
  # Keyword argument lets you access reservations by date if you want


# Basically, I never want to access Room & Hotel class again.  From now on, I want to access rooms and their status inside the Availability/calendar-- by looking at a specific date or date range, and looking at the status on that date.

#Ex: If the day is 9/7, room ID 2 should change its status to :booked.
# Reservation.new
def initialize(room_id, startyear, startmonth, startday, endyear, endmonth, endday)
  # Checks if room is available first
  unless Availability.all_available_rooms(startyear, startmonth, startday, endyear, endmonth, endday).include?(room_id)
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
                status = :booked
              end
              # binding.pry
            end
          end
        end
      end
    end
    wanteddate += 1
  end
end

  # Outputs details as a hash: room, length of stay (x nights), date of checkout (last day of reservation), and cost  of reservation

end # end of class

# Reservation.new(20, 2017, 9, 6, 2017, 9, 7)
