require_relative 'rooms'
require 'date'

class Availability
  attr_reader :calendar, :all_available_rooms, :create_calendar
  @@calendar = []

  def self.create_calendar
    current_date = Date.today
    last_day = current_date + 365

    roominfo = []
    hotel = Hotel.new
    hotel.rooms.each do |room|
      id = room.id
      status = room.status
      roominfo << {id => status}
    end

    until current_date == last_day
      @@calendar << {current_date => roominfo}
      current_date += 1
    end
  end

  def self.calendar
    return @@calendar
  end

  def self.set_calendar(new_cal)
    @@calendar = new_cal
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

  def self.all_reservations(year, month, day)
    check_date = Date.new(year,month,day)

    bookedrooms = []

      self.calendar.each do |days|
        days.each do |date, roominfo|
          if check_date == date
            roominfo.each do |rooms|
              rooms.each do |id, status|
                if status == :booked
                  bookedrooms << id
                end
              end
            end
          end
        end
      end

    return bookedrooms
  end



end #end of class
