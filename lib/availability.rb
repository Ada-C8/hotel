require_relative 'rooms'
require 'date'

class Availability
  @@calendar = []

  # Creates a calendar array that includes a Date object key (for each day from generation until one year later) with a value of an array of each room and its status on that day
  def self.create_calendar
    current_date = Date.today
    last_day = current_date + 366

    roominfo = []
    hotel = Hotel.new
    hotel.rooms.each do |room|
      id = room.id
      status = room.status
      roominfo << {id => status}
    end

    until current_date == last_day
      roominfo = Marshal.load(Marshal.dump(roominfo))
      @@calendar << {current_date => roominfo}
      current_date += 1
    end
  end

  def self.calendar
    return @@calendar
  end

  # Made for resetting the calendar class variable for testing when multiple calendars are being created
  def self.set_calendar(new_cal)
    @@calendar = new_cal
  end

  # Iterate through the calendar to find specific date ranges and return the available rooms for all days in the given range
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

  # Iterate through calendar to find all reserved rooms on a given date
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

  # Iterate through calendar to find all rooms blocked off for a specific day (not attached to a specific block)
  def self.all_blocked_rooms(year, month, day)
    check_date = Date.new(year,month,day)
    blockedrooms = []
    self.calendar.each do |days|
      days.each do |date, roominfo|
        if check_date == date
          roominfo.each do |rooms|
            rooms.each do |id, status|
              if status == :blocked
                blockedrooms << id
              end
            end
          end
        end
      end
    end

    return blockedrooms
  end

  # Find the still-available rooms in one specific block
  def self.block_available_rooms(id)
    chosen_block = ""
    Block.all_blocks.each do |block|
      if block.block_id == id
        chosen_block = block
      end
    end

    if chosen_block == ""
      raise ArgumentError.new("That room block ID does not exist.")
    end

    return chosen_block.blocked_rooms.count
  end

end #end of class
