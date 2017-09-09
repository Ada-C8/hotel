require 'pry'
require 'date'
require_relative 'Reservation'
require_relative 'BlockReservation'
require_relative 'Booking'

module HotelBooking

  class Room
    attr_reader :id, :nightly_rate, :type, :reserv_ids, :all_dates, :block_ids, :blocks_available
    # :status

    @@total_num_rooms = 20

    def initialize(id_number, nightly_rate = 200)
      @id = id_number
      @nightly_rate =  nightly_rate
      @type = :standard # is this necessary
      @reserv_ids = []
       # holds all reservations, a hash with reservation ids as keys and values as the date range of the reservation ### check-out date should not be included
      @block_ids = []
      @all_dates = []
      @blocks_available = [] #block ids that have not been claimed

      # @status =  :available #not sure if status is needed anymore.maybe a method, available?

    end

    def reserve_room(check_in_str,check_out_str,reservation_id, guest_id=nil)
      check_in = Date.parse(check_in_str)
      check_out = Date.parse(check_out_str)

      check_valid_dates(check_in,check_out)


      (check_in...check_out).each do |date|
        return false if @all_dates.include?(date)
      end

      (check_in...check_out).each do |date|
        @all_dates << date
      end

      @reserv_ids << reservation_id

        ### future note- would it be helpful to sort, and do binary search instead of include? look into it


    end

    def reserve_block_room(check_in_str,check_out_str,reservation_id, block_id, guest_id=nil)

      #TODO: maybe reserve block room should only take in a Block id, since the check-in and check-out dates will be whatever the dates of the block are

    #def reserve_block_room(block_id, reservation_id)
      # block = Hotel::BookingProgram.all_blocks.find_block_by_id(block_id)
      #
      # check_in = block.check_in.to_s
      # check_out = block.check_out.to_s
      #
      # check_in = Date.parse(check_in_str)
      # check_out = Date.parse(check_out_str)

      # check_valid_dates(check_in,check_out)

      raise ArgumentError.new("This Block room is not available for this block reservation") if !(@blocks_available.include?(block_id))

      @blocks_available.delete(block_id)


    end


    def block_room(check_in_str,check_out_str,block_id)
      check_in = Date.parse(check_in_str)
      check_out = Date.parse(check_out_str)

      check_valid_dates(check_in,check_out)

      (check_in...check_out).each do |date|
        return false if @all_dates.include?(date)
      end

      @blocks_available << block_id

      (check_in...check_out).each do |date|
        @all_dates << date
      end

    end

    def self.all
      i = 1
      all_rooms = []

      until all_rooms.count == @@total_num_rooms
        room =  HotelBooking::Room.new(i)
        all_rooms << room
        i += 1
      end

      return all_rooms
    end


    def self.find_by_id(room_id)
      self.all.each {|room| return room if room.id == room_id}

      raise ArgumentError.new "Sorry, we don't have a room matching that ID number."
    end


    def available_all_days?(check_in_str, check_out_str)
      check_in = Date.parse(check_in_str)
      check_out = Date.parse(check_out_str)

      (check_in..check_out).each do |date| ### double check this logic, inclusive rather than exclusive
        return false if @all_dates.include?(date)
      end

      return true
    end

    def check_valid_dates(check_in, check_out)
      if check_in < Date.today || check_out < Date.today
        raise ArgumentError.new("Can't make reservations for days earlier than today")
      end

      if check_in.class != Date ||check_out.class != Date
        raise ArgumentError.new("Please provide a valid date")
      end

      if check_out < check_in
        raise ArgumentError.new("Invalid Date Range: Check out date is earlier than check-in date.")
      end

    end

  end

end

# binding.pry


##########Wave 2

# def available?(date_str)
#   #date format is year, month, day
#   date = Date.parse(date_str)
#   return false if @all_dates.include?(date)
#   return true
# end

#
# def available_all_days?(check_in_str, check_out_str)
#   check_in = Date.parse(check_in_str)
#   check_out = Date.parse(check_out_str)
#
#   (check_in...check_out).each do |date|
#     return false if available?(date) == false
#   end
#
#   return true
# end

# def available_all_days?(check_in_str, check_out_str)
#   check_in = Date.parse(check_in_str)
#   check_out = Date.parse(check_out_str)
#
#   (check_in...check_out).each do |date|
#     return false if @all_dates.include?(date)
#   end
#
#   return true
# end

# def reserve_room(check_in,check_out,res_id, guest_id,room_id)
#   if available_all_days?(check_in,check_out)
#     reserved_dates[res_id] = (check_in...check_out) #range of dates, maybe stored as array?
#
#   end
#
# end




#BEGIN RESCUE CLAUSE

# begin
#   if check_in < Date.today || check_out < Date.today
#     raise ArgumentError.new("Can't make reservations for days earlier than today")
#   end
#
#   if check_in.class != Date ||check_out.class != Date
#     raise ArgumentError.new("Please provide the date in the following format: \n YYYY-MM-DD")
#   end

# rescue ArgumentError => exception
#   puts "Encountered an error: #{exception}"
# end
