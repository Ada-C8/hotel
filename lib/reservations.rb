require_relative 'availability'
require 'date'

class Reservation
  attr_reader :total_cost, :total_stay

  # Iterate through calendar for specific room and date range  and change a rooms' status on those dates to :booked
  def initialize(room_id, startyear, startmonth, startday, endyear, endmonth, endday)
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

  # Reserve a blocked room from a specific block
  def self.reserve_from_block(id)
    chosen_block = ""
    Block.all_blocks.each do |block|
      if block.block_id == id
        chosen_block = block
      end
    end

    if chosen_block == ""
      raise ArgumentError.new("That room block ID does not exist.")
    end

    checkin_date = chosen_block.checkin_date
    checkout_date = chosen_block.checkout_date
    wanteddate = checkin_date

    room_id = chosen_block.blocked_rooms.pop

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
