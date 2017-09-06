require 'date'
require_relative 'room'
require_relative 'reservation'

module Hotel

  class California
    attr_reader :all_rooms, :all_reservations

    def initialize
      @num_of_rooms = 20
      @rate = 200
      @all_rooms = {}
      (1..@num_of_rooms).each do |room|
        @all_rooms[room] = Hotel::Room.new(room, @rate)
      end
      @all_reservations = []
    end

    def create_reservation(start_date, end_date, room)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      # dates = (start_date..end_date).map(&:to_s)
      # if dates & @all_reservations[room - 1][0].dates == nil
      if @all_rooms[room].status == :available
        # need to makes status change only for the dates provided, otherwise :available
        # @all_reservations[i][0].dates.pop/remove last date allow for same day booking of that room
        # @all_rooms[room - 1].status = :occupied
        reservation = [Hotel::Reservation.new(start_date, end_date), @all_rooms[room]]
        @all_reservations << reservation
      else
        raise ArgumentError.new("This room is unavailable")
      end

    end

    def find_available(date)
      occupied = find_by_date(date)
      temp = []
      occupied.each_index do |i|
        temp << occupied[i][1].room_num
      end
      # unoccupied = @all_rooms.delete(occupied[i][1].room_num)
      # make new variable that deletes the occupied occurences
    end

    def total(num)
      num_nights = @all_reservations[num-1][0].dates.length - 1
      return num_nights * @rate
    end

    def find_by_date(date)
      # .map! somewhere?
      valid_date = Date.parse(date)
      by_date = []
      @all_reservations.each_index do |i|
        if @all_reservations[i][0].dates.include? valid_date.to_s
          by_date << @all_reservations[i]
        end
      end
      return by_date
    end

  end #end of California
end #end of Hotel

new = Hotel::California.new
new.create_reservation("2017-03-13", "2017-03-16", 5)
new.create_reservation("2017-04-13", "2017-04-16", 5)
new.find_available("2017-03-13")
