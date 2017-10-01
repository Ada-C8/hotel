require 'date'
require_relative 'room'

module Reservable

  def check_dates(start_date, end_date)

    raise TypeError.new("#{start_date} must be of type Date") if start_date.class != Date
    raise TypeError.new("#{end_date} must be of type Date") if end_date.class != Date
    raise ArgumentError.new("Check out must be later than check in") if start_date >= end_date
    raise ArgumentError.new("Can't reserve a room for a date before today") if start_date < Date.today

  end

  def check_room_num(num)
    raise TypeError.new("#{num} must of type Integer") if num.class != Integer
    raise ArgumentError.new("Invalid number of rooms") if num < 1
  end

  def check_room(room)
    raise TypeError.new("#{room} must be of type Hotel::Room") if room.class != Hotel::Room
  end

  def check_room_block(room_block, check_in, check_out)
    raise TypeError.new("Block of rooms must be an array of Room objects") if room_block.class != Array || room_block[0].class != Hotel::Room

    raise ArgumentError.new("Invalid number of rooms in block") if room_block.length > Hotel::Block::MAX_ROOMS || room_block.length < 1

    raise ArgumentError.new("Can't have unavailable rooms in the block") if room_block.any? { |room| room.booked?(check_in, check_out) || room.blocked?(check_in, check_out) }
  end

  def check_rate(rate)
    raise TypeError.new("#{rate} must be of type Integer") if rate.class != Integer
    raise ArgumentError.new("Rate must be greater than 0") if rate < 1
  end

  def check_discount(discount)
    # must be decimal representing percentage of full cost (e.g. 0.8 for 80% of orig rate)
    raise TypeError.new("#{discount} must be of type Float") if discount.class != Float
    raise ArgumentError.new("Not a discounted rate") if discount >= 1 || discount <= 0
  end

  def include?(date)
    return date >= @check_in && date < @check_out
  end

end
