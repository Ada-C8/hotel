require_relative 'availability'
require 'date'
require 'pry'
class Reservation
  # < Availability
attr_reader :total_cost, :total_stay

def initialize(room_id, startyear, startmonth, startday, endyear, endmonth, endday)
  if Availability.all_available_rooms(startyear, startmonth, startday, endyear, endmonth, endday).include?(room_id) == false
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


  total_stay = (checkout_date - checkin_date).to_i
  @total_cost = total_stay * 200

end



end # end of class
