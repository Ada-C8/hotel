require_relative 'room'
require_relative 'reservation'
require_relative 'dates'

module Hotels
  # Contains the methods related to reserving rooms and viewing reservations
  class Hotel
    attr_reader :rooms, :reservations, :blocks

    def initialize(name)
      @name = name
      @rooms = Array.new(20) { |i| Hotels::Room.new(i + 1) }
      @reservations = []
      @blocks = []
    end

    def list_all_rooms
      @rooms.map(&:room_name)
    end # returns Array of Room name Strings

    def reserve_room(checkin, checkout = nil)
      check_available_rooms(checkin, checkout)
      reservation = Hotels::Reservation.new(checkin, checkout)
      reservation.id = generate_id(checkin)
      generate_room(reservation, checkin, checkout)
      reservation.calc_total
      @reservations << reservation
      reservation
    end # returns successful Reservation

    def reserve_by_room(checkin, checkout, room_no)
      room_no_check(room_no)
      desired_room = @rooms.select { |room| room.room_id == room_no }
      available_rooms = check_available_rooms(checkin, checkout)
      room_no_availability(desired_room[0], available_rooms)

      reservation = Hotels::Reservation.new(checkin, checkout)
      reservation.rooms = desired_room
      reservation.calc_total
      @reservations << reservation
      reservation
    end # returns a successful Reservation made using room ID or an error

    def list_reservations(date)
      @reservations.select { |obj| obj.dates.include? date }
    end # returns Array of Reservations for the (date)

    def unreserved?(checkin, checkout = nil)
      date_range = []
      Hotels::Dates.add_dates(date_range, checkin, checkout, 1)
      unreserved = []
      date_range.each do |date|
        unreserved_rooms = {}
        unreserved_rooms[date] = list_unreserved_rooms(date)
        unreserved << unreserved_rooms
      end
      unreserved
    end # returns Array of Hashes (Date as keys; Array of Rooms as values)

    def book_block(room_count, checkin, checkout = nil)
      valid_room_count?(room_count)
      available = check_available_rooms(checkin, checkout)
      if room_count <= available.length
        booked = Hotels::Reservation.new(checkin, checkout, room_count)
        booked.block_id = generate_id(checkin)
        generate_room(booked, checkin, checkout, room_count)
        booked.calc_total
        @blocks << booked
        booked
      end
    end # returns the Reservation of the block booking

    def check_block(_block_id)
      reference_block = @blocks.select(&:block_id)
      booked_from_block = @reservations.select(&:block_id)
      bool = (reference_block[0].rooms.length != booked_from_block.length)
      raise ArgumentError, 'All the rooms have been reserved' unless bool
    end

    def reserve_block(block_id, room_count)
      reference_block = @blocks.select(&:block_id)
      checkin = reference_block[0].dates[0]
      checkout = reference_block[0].dates[-1] + 1
      reserve_check(block_id, room_count)

      book_block = Hotels::Reservation.new(checkin, checkout, room_count)
      book_block.id = generate_id(checkin)
      book_block.block_id = block_id
      select_block_rooms(block_id, book_block, room_count)
      book_block.calc_total
      @reservations << book_block
      book_block
    end # returns successful Reservation from block

    private

    def list_unavailable(date)
      reserved_rooms = @reservations.select { |obj| obj.dates.include? date }
      blocked_rooms = @blocks.select { |obj| obj.dates.include? date }
      reserved_blocks = reserved_rooms.select { |obj| obj.block_id.to_i > 0 }
      (reserved_rooms - reserved_blocks) + blocked_rooms
    end # returns Array of Reservations/Blocks for the (date)

    def list_rooms(method)
      list = method
      rooms = []
      list.each { |res| rooms << res.rooms }
      rooms.flatten
    end # returns an Array of Rooms that are selected based on the method

    def list_reserved_rooms(date)
      list_rooms(list_reservations(date))
    end # returns an Array of Rooms that are reserved for the (date)

    def list_unreserved_rooms(date)
      @rooms - list_reserved_rooms(date)
    end # returns an Array of Rooms that are unreserved for the (date)

    def list_unavailable_rooms(date)
      list_rooms(list_unavailable(date))
    end # returns an Array of Rooms that are unavailable for the (date)

    def list_available_rooms(date)
      @rooms - list_unavailable_rooms(date)
    end # returns an Array of Rooms that are available for the (date)

    def available_rooms(checkin, checkout = nil)
      date_range = []
      Hotels::Dates.add_dates(date_range, checkin, checkout, 1)
      available = []
      date_range.each do |date|
        available_rooms = list_available_rooms(date)
        available << available_rooms
      end
      available
    end # returns an Array of Hashes (Date as keys, Array of Room as values)

    def check_available_rooms(checkin, checkout = nil)
      available_rooms = available_rooms(checkin, checkout)
      minimum_viable = available_rooms.inject(:'&')
      if minimum_viable.length >= 1
        return minimum_viable
      else
        raise ArgumentError, 'No rooms available during your selected date(s)'
      end
    end # returns an Array of Rooms or an error

    def booked_ids(block_id, _room_count)
      check_block(block_id)
      booked_from_block = @reservations.select(&:block_id)
      unless booked_from_block.nil?
        booked_rooms = booked_from_block.map(&:rooms)
        booked_rooms = booked_rooms.flatten
        booked_ids = booked_rooms.map(&:room_id)
        return booked_ids
      end
    end # returns the IDs of Reservations made from the (block_id)

    def room_no_check(room_no)
      bool = (1..20).cover? room_no
      raise ArgumentError, 'Not a valid room number' unless bool
    end

    def room_no_availability(desired, available)
      bool = available.include? desired
      raise ArgumentError, 'Room is not available for that time' unless bool
    end

    def reserve_check(block_id, room_count)
      reference_block = @blocks.select(&:block_id)
      rooms = reference_block[0].rooms
      booked_ids = booked_ids(block_id, room_count).to_a.flatten
      bool = (rooms.length - booked_ids.length >= room_count)
      raise ArgumentError, 'Not enough unreserved block rooms' unless bool
    end

    def valid_room_count?(block_room_count)
      bool = (1..5).cover? block_room_count
      raise ArgumentError, 'Can only block 1-5 rooms' unless bool
    end

    def select_block_rooms(block_id, reservation, room_count = 1)
      reference_block = @blocks.select(&:block_id)
      rooms = reference_block[0].rooms
      booked_ids = booked_ids(block_id, room_count).to_a.flatten
      until reservation.rooms.length == room_count
        room = rooms.sample(1)
        room_id = room[0].room_id
        reservation.rooms << room unless booked_ids.include? room_id
        booked_ids << room_id
      end
    end # adds Room(s) to the Reservation from a block

    def generate_room(reservation, checkin, checkout, room_count = 1)
      available_rooms = check_available_rooms(checkin, checkout)
      full_rooms = @rooms - available_rooms
      until reservation.rooms.length == room_count
        room = available_rooms.sample(1)[0]
        reservation.rooms << room unless full_rooms.include? room
        full_rooms << room
      end
    end # adds randomly sampled Room(s) to the Reservation

    def generate_id(checkin)
      other_ids = @reservations.map(&:id)
      new_id = ''
      until new_id.length > 1
        initial_date = checkin.to_s.delete('-')
        random_alphabet = ('A'..'Z').to_a.sample(10).join
        random_digits = (0..9).to_a.shuffle.join
        temp_id = "#{initial_date}#{random_alphabet}#{random_digits}"
        new_id = temp_id unless other_ids.include? temp_id
      end
      new_id
    end # creates a new unique ID number
  end # Hotel class
end # Hotels module
