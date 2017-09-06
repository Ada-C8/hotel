require 'pry'
require 'date'
require_relative 'Reservation'

module Hotel

  class Room
    attr_reader :id, :nightly_rate, :type, :reserv_id_and_dates, :all_dates
    # :status

    @@total_num_rooms = 20

    def initialize(id_number, nightly_rate = 200)
      @id = id_number
      @nightly_rate =  nightly_rate
      @type = :standard
      @reserv_id_and_dates = {}
       # holds all reservations, a hash with reservation ids as keys and values as the date range of the reservation ### check-out date should not be included
      @all_dates = []

      # @status =  :available #not sure if status is needed anymore.maybe a method, available?

    end

    def reserve_room(check_in_str,check_out_str,reservation_id, guest_id)
      check_in = Date.parse(check_in_str)
      check_out = Date.parse(check_out_str)

      (check_in...check_out).each do |date|
        return false if @all_dates.include?(date)
      end

      @reserv_id_and_dates[reservation_id] = []

      (check_in...check_out).each do |date|
        @reserv_id_and_dates[reservation_id] << date
      end

      @all_dates = @reserv_id_and_dates.values.flatten
      ### future note- would it be helpful to sort, and do binary search instead of include? look into it

    end

    def self.all
      i = 1
      all_rooms = []

      until all_rooms.count == @@total_num_rooms
        room =  Hotel::Room.new(i)
        all_rooms << room
        i += 1
      end

      return all_rooms
    end


    def self.find_by_id(room_id)
      self.all.each {|room| return room if room.id == room_id}

      raise ArgumentError.new "Sorry, we don't have a room matching that ID number."
    end

  end

end

# binding.pry


##########Wave 2

# def available?(date_str)
#   #date format is year, month, day
#   date = Date.parse(date_str)
#   return false if @reserv_id_and_dates.values.include?(date)
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
