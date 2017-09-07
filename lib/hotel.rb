require 'awesome_print'
require_relative 'room'
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
      @rooms.map(&:room_name)
    end

    def reserve_room(checkin, checkout = nil)
      # W1-2. Can reserve a room for a given date range
      # W2-2. Can reserve an available room for a given date range
      unless full?(checkin)
        reservation = Hotels::Reservation.new(checkin, checkout)
        reservation.id = id_generator(checkin)
        random_room(reservation, checkin)
        reservation.calc_total
        @reservations << reservation
        reservation
      end
    end

    def check_reserved(date)
      # W1-3. Can access the list of reservations for a specific date
      @reservations.select { |obj| obj.dates.include? date }
    end

    def total_cost(reservation)
      # W1-4. Can get the total cost for a given reservation
      reservation = id_check(reservation)
      reservation.total_cost if reservation.class == Hotels::Reservation
    end

    def check_unreserved(checkin, checkout = nil)
      # W2-1. Can view a list of rooms (not reserved) for a given date range
      date_range = []
      if checkout.nil?
        date_range << checkin
      else
        Hotels::Reservation.shovel_dates(checkin, checkout, date_range, 1)
      end
      permissable_rooms = []
      unreserved_rooms(date_range, permissable_rooms)
      permissable_rooms
    end

    def id_generator(checkin)
      initial_date = checkin.to_s.delete('-')
      random_alphabet = ('A'..'Z').to_a.sample(10).join
      random_digits = (0..9).to_a.shuffle.join
      "#{initial_date}#{random_alphabet}#{random_digits}"
    end # generates and adds a room id number for a successful reservation

    def random_room(reservation, checkin)
      unavailable = unavailable_rooms(checkin)
      until reservation.rooms.length == 1
        room_no = @rooms.sample(1)[0]
        reservation.rooms << room_no unless unavailable.include? room_no
      end
    end # adds a Room to the reservation

    def unreserved_rooms(date_range, array)
      date_range.each do |date|
        bad_rooms = unavailable_rooms(date)
        good_rooms = @rooms - bad_rooms
        ok_room = {}
        ok_room[date] = good_rooms
        array << ok_room
      end
    end # adds vacant Rooms during a Date range to the selected Array

    def unavailable_rooms(date)
      reservations = check_reserved(date)
      no_vacancy = []
      reservations.each do |reservation|
        reservation.rooms.each do |room|
          no_vacancy << room
        end
      end
      no_vacancy
    end # returns an Array of reservations for the selected date

    def full?(checkin)
      !(0..19).cover? unavailable_rooms(checkin).length
    end # returns T/F if all the hotel rooms are taken on the selected date

    def id_check(reservation)
      reservation = reservation
      if reservation.class == String
        @reservations.each_with_index do |appt, index|
          reservation = @reservations[index] if reservation.equal? appt.id
        end
      end
      reservation
    end # returns the corresponding reservation to a given reservation ID
  end # Hotel class
end # Hotels module
