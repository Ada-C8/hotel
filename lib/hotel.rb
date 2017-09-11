require 'date'
require_relative 'room'
require_relative 'reservation'
require_relative 'block'

module Hotel

  class California
    attr_reader :all_rooms

    def initialize
      @num_of_rooms = 20
      @rate = 200
      @all_rooms = {}
      (1..@num_of_rooms).each do |room|
        @all_rooms[room] = Hotel::Room.new(room, @rate)
      end
    end

    def find_available(date)
      valid_date = Date.parse(date)
      by_date = []
      @all_rooms.each do |k, v|
        if @all_rooms[k].reservations.length == 0
          by_date << @all_rooms[k].room_num
        elsif @all_rooms[k].reservations.length != 0
          @all_rooms[k].reservations.each_index do |i|
            unless @all_rooms[k].reservations[i].dates.include? valid_date.to_s
              by_date << @all_rooms[k].room_num
            end
          end
        end
      end
      return by_date
    end

    def total(room, reservation)
      num_nights = @all_rooms[room].reservations[reservation].dates.length - 1
      return num_nights * @rate
    end

    def find_by_date(date)
      valid_date = Date.parse(date)
      by_date = []
      @all_rooms.each do |k, v|
        if @all_rooms[k].reservations.length != 0
          @all_rooms[k].reservations.each_index do |i|
            if @all_rooms[k].reservations[i].dates.include? valid_date.to_s
              by_date << @all_rooms[k]
            end
          end
        end
      end
      return by_date
    end

    def all_reservations
      all = []
      @all_rooms.each do |k, v|
        if @all_rooms[k].reservations.length != 0
          all << @all_rooms[k].reservations
        end
      end
      return all
    end

    def create_block(start_date, end_date, num_rooms)
      if num_rooms > 5
        raise ArgumentError.new("You cannot block reserve more then 5 rooms.")
      end

      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      dates = (start_date..end_date).map(&:to_s)
      
      available_rooms = []
      dates.each {|date| available_rooms << find_available(date)}
      available_rooms = available_rooms.inject(:&).first(num_rooms)

      if available_rooms.length < num_rooms
        raise ArgumentError.new("There are not enough rooms available for those dates.")
      end

      available_rooms.each do |id|
        @all_rooms[id].reservations << Hotel::Block.new(start_date, end_date)
      end
    end

    def reserve_block
      # currently only for all blocks not specific blocks
      reserved = false
      @all_rooms.each do |id, room|
        room.reservations.each_index do |resId|
          if reserved == false && room.reservations[resId].class == Hotel::Block && room.reservations[resId].status == :available
            room.reservations[resId].status = :occupied
            reserved = true
          end
        end
      end
    end

  end #end of California
end #end of Hotel
