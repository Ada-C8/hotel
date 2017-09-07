require 'awesome_print'
require_relative 'room'
require_relative 'reservation'

module Hotels
  # Contains the methods related to reserving rooms and viewing reservations
  class Hotel
    attr_reader :rooms, :reservations, :blocks

    def initialize
      # W1-C1 The hotel has 20 rooms, and they are numbered 1 through 20
      @rooms = Array.new(20) { |i| Hotels::Room.new(i + 1) }
      @reservations = []
      @blocks = []
    end

    def list_rooms
      # W1-US1 Can access the list of all of the rooms in the hotel
      @rooms.map(&:room_name)
    end

    def reserve_room(checkin, checkout = nil)
      # W1-US2 Can reserve a room for a given date range
      # W1-C4 Any room can be reserved at any time
      # W2-US2 Can reserve an available room for a given date range
      full?(checkin)
      reservation = Hotels::Reservation.new(checkin, checkout)
      reservation.id = id_generator(checkin)
      random_room(reservation, checkin)
      reservation.calc_total
      @reservations << reservation
      reservation
    end

    def check_reserved(date)
      # W1-US3 Can access the list of reservations for a specific date
      @reservations.select { |obj| obj.dates.include? date } + @blocks.select { |obj| obj.dates.include? date }
    end

    def total_cost(reservation)
      # W1-US4 Can get the total cost for a given reservation
      reservation = id_check(reservation)
      reservation.total_cost if reservation.class == Hotels::Reservation
    end

    def check_unreserved(checkin, checkout = nil)
      # W2-US1 Can view a list of rooms (not reserved) for a given date range
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

    def book_block(checkin, checkout = nil, room_count)
      # W3-US1 Can create a block of rooms
      full?(checkin)
      if valid_block?(room_count)
        booked = Hotels::Reservation.new(checkin, checkout)
        booked.block_id = block_id_gen(checkin, room_count)
        random_room(booked, checkin, room_count)
        booked.calc_total
        @blocks << booked
        booked
      end
    end

    def id_generator(checkin)
      initial_date = checkin.to_s.delete('-')
      random_alphabet = ('A'..'Z').to_a.sample(10).join
      random_digits = (0..9).to_a.shuffle.join
      "#{initial_date}#{random_alphabet}#{random_digits}"
    end # generates and adds a room id number for a normal reservation

    def block_id_gen(checkin, room_count)
      initial_date = checkin.to_s.delete('-')
      random_digits = (0..9).to_a.shuffle.join
      "#{initial_date}#{room_count}#{random_digits}"
    end # generates and adds a block id number for a block reservation

    def random_room(reservation, checkin, room_count = 1)
      unavailable = unavailable_rooms(checkin)
      # unavailable_num = 
      until reservation.rooms.length == room_count
        room_no = @rooms.sample(1)[0]
        reservation.rooms << room_no unless unavailable.include? room_no
        # unavailable <<
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
      raise ArgumentError if check_reserved(checkin).length == 20
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

    def valid_block?(room_count)
      (1..5).include? room_count
    end
  end # Hotel class
end # Hotels module


conrad = Hotels::Hotel.new
checkin = Date.new(2017, 10, 31)
checkout = Date.new(2017, 11, 4)


conrad.book_block(checkin, checkout, 5)
conrad.book_block(checkin, checkout, 5)

conrad.reserve_room(checkin, checkout)
conrad.reserve_room(checkin, checkout)
conrad.reserve_room(checkin, checkout)
conrad.reserve_room(checkin, checkout)
conrad.reserve_room(checkin, checkout)


puts conrad.reservations.length
puts conrad.blocks.length
# ap conrad.check_reserved(checkin)
ap conrad.unavailable_rooms(checkin)
ap conrad.check_unreserved(checkin)
