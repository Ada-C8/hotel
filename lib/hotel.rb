require 'awesome_print'
# require_relative 'room'
require_relative 'reservation'

module Hotels
  # Contains the methods related to reserving rooms and viewing reservations
  class Hotel
    attr_reader :rooms, :reservations

    def initialize
      @rooms = Array.new(20) { |i| Hotels::Room.new(i + 1) }
      @reservations = []
    end

    def list_rooms
      # W1-1. Can access the list of all of the rooms in the hotel
      @rooms.map(&:room_id)
    end

    def reserve_room(checkin, checkout = nil)
      # W1-2. Can reserve a room for a given date range
      if full?(checkin)
        reservation = Hotels::Reservation.new(checkin, checkout)
        reservation.id = room_id(checkin)
        random_room(reservation, checkin)
        @reservations << reservation
        reservation
      end
    end

    def check_reserved(date)
      # W1-3 Can access the list of reservations for a specific date
      @reservations.select { |obj| obj.dates.include? date }
    end

    def total_cost(reservation)
      # W1-4. Can get the total cost for a given reservation
      reservation = id_check(reservation)
      if reservation.class == Hotels::Reservation
        reservation.calc_total
        reservation.total_cost
      end
    end

    def room_id(checkin)
      initial_date = checkin.to_s.delete('-')
      random_alphabet = ('A'..'Z').to_a.sample(10).join
      random_digits = (0..9).to_a.shuffle.join
      "#{initial_date}#{random_alphabet}#{random_digits}"
    end

    def random_room(reservation, checkin)
      unavailable = unavailable_rooms(checkin)
      until reservation.rooms.length == 1
        room_no = rand(1..20)
        reservation.rooms << room_no unless unavailable.include? room_no
      end
    end

    def unavailable_rooms(date)
      unavailable = check_reserved(date)
      no_vacancy = []
      unavailable.each do |reservation|
        reservation.rooms.each do |room|
          no_vacancy << room
        end
      end
    end

    def full?(checkin)
      (0..19).cover? unavailable_rooms(checkin).length
    end

    def id_check(reservation)
      reservation = reservation
      if reservation.class == String
        @reservations.each_with_index do |appt, index|
          reservation = @reservations[index] if reservation.equal? appt.id
        end
      end
      reservation
    end
  end # Hotel class
end # Hotels module
