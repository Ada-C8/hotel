require 'date'
require_relative 'room.rb'
require_relative 'reservations.rb'
require 'pry'

module Hotel_System

  class Hotel

    attr_reader :all_rooms, :room_list, :list_of_rooms, :room_number, :room_object, :room_price

    attr_accessor :all_reservations

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
      @all_reservations << Reservations.new(room, check_in, check_out)
    end

def reservations_by_date(date)
  date = Date.parse(date)
  @reservations_by_date = []
  @all_reservations.each do |reservation|
    if date >= reservation.check_in && date < reservation.check_out
      @reservations_by_date << reservation
    end
  end
  return @reservations_by_date
end
    # def reservations_by_date(date)
    #   date = Date.parse(date)
    #   p date
    #   @reservations_by_date = []
    #   p @all_reservations
    #   p @all_reservations.length
    #   @all_reservations.each do |reservation|
    #     if date >= reservation.check_in && date < reservation.check_out
    #       @reservations_by_date << reservation
    #     end
    #     return @reservations_by_date
    #   end


    # end

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
