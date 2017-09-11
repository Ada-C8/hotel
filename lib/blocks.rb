require_relative 'reservations'
require 'date'

class Block
  attr_reader :total_cost, :block_id, :blocked_rooms, :checkin_date, :checkout_date
  @@every_block = []

  # Create a new block by iterating through the calendar for the given date range and taking the first x rooms with a status of available and changing their status to :blocked
  def initialize(room_count, startyear, startmonth, startday, endyear, endmonth, endday, block_id)
    if room_count > 5 || room_count.class != Integer || room_count < 2
      raise ArgumentError.new("Rooms must be blocked in quantities between 2 and 5.")
    end

    Block.all_blocks.each do |block|
      if block.block_id == block_id
        raise ArgumentError.new("That ID is taken by another block.  Please create a unique ID.")
      end
    end

    @block_id = block_id
    @blocked_rooms = Availability.all_available_rooms(startyear, startmonth, startday, endyear, endmonth, endday)[0...room_count]

    @checkin_date = Date.new(startyear,startmonth,startday)
    @checkout_date = Date.new(endyear,endmonth,endday)
    wanteddate = checkin_date

    until wanteddate == checkout_date
      Availability.calendar.each do |days|
        days.each do |date, roominfo|
          if wanteddate == date
            roominfo.each do |rooms|
              rooms.each do |id, status|
                if blocked_rooms.include?(id)
                  rooms[id] = :blocked
                end
              end
            end
          end
        end
      end
      wanteddate += 1
    end

    @@every_block << self

    total_stay = (@checkout_date - @checkin_date).to_i
    @total_cost = total_stay * 175

    return @blocked_rooms
  end

  def self.all_blocks
    return @@every_block
  end

end # end of class
