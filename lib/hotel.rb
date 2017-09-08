require 'date'
require_relative 'room.rb'
require_relative 'reservations.rb'
require 'pry'

module Hotel_System

  class Hotel

    attr_reader :all_rooms, :room_list, :list_of_rooms, :room_number, :reservation

    attr_accessor :all_reservations, :room_object, :room_price, :available_rooms_hash, :avail_check_by_date, :available_room_list, :master_list

    def initialize(num_of_rooms)
      @all_rooms = fill_hotel(num_of_rooms)
      @all_reservations = []
    end

    def return_room_object_by_num(room_number)
      room_object = @all_rooms[room_number - 1]
    end

    def list_of_rooms
      room_list = []
      @all_rooms.each do |room|
        room_list << room.room_number
      end
      return room_list
    end

    def make_reservation(room_number, check_in, check_out)
      room = return_room_object_by_num(room_number)
      @reservation = Reservations.new(room, check_in, check_out)
      @all_reservations << @reservation
      return @reservation
    end

    def date_object_checker(date)
      if date.class != Date
        date = Date.parse(date)
      end
      return date
    end

    def reservations_by_date(date)
      date = date_object_checker(date)
      @reservations_by_date = []
      @all_reservations.each do |reservation|
        if date >= reservation.check_in && date < reservation.check_out
          @reservations_by_date << reservation
        end
      end
      return @reservations_by_date
    end

    def available_room_hash
      @available_rooms_hash = {}
      (1..20).each do |num|
        @available_rooms_hash[num] = :available
      end
      return @available_rooms_hash
    end

    def availability_room_hash_by_date(date)
      @list_of_rooms_avail_on_date = available_room_hash
      if reservations_by_date(date).length == 0
        return @list_of_rooms_avail_on_date
      else
        reservations_by_date(date).each do |res|
          @list_of_rooms_avail_on_date[res.room.room_number] = :reserved
        end
      end
      return @list_of_rooms_avail_on_date
    end

    def available_rooms_by_date(date)
      @available_room_list = []
      availability_room_hash_by_date(date).each do |k,v|
        if v == :available
          @available_room_list << k
        end
      end
      return @available_room_list
    end

    def avail_rooms_by_daterange(date_range)
      @master_list = []
      date_range.each do |date|
        @master_list << available_rooms_by_date(date)
      end
      @master_list = @master_list.inject(:&)
      # p @master_list
    end

    def inquiry_date_range_generator(check_in, check_out)
      check_in = date_object_checker(check_in)
      check_out = date_object_checker(check_out)
      @inquiry_date_range = [check_in]
      date = check_in
      until date.next == check_out
        date = date.next
        @inquiry_date_range << date
      end
      return @inquiry_date_range
    end

    def avail_checker(room_number, check_in, check_out)
      date_range = inquiry_date_range_generator(check_in, check_out)
      boolean = avail_rooms_by_daterange(date_range).include? room_number
      if boolean == false
        raise ArgumentError.new("Room not available")
      else
        make_reservation(room_number, check_in, check_out)
      end
    end

    private

    def fill_hotel(num_of_rooms)
      room_array = []
      num_of_rooms.times do |i|
        room_array << Room.new(i + 1, 200)
      end
      return room_array
    end

  end

end
