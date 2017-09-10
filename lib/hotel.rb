require 'date'

module Hotel
  STANDARD_RATE = 200
  NUMBER_OF_ROOMS = 20

  class Hotel

    attr_reader :rooms, :reservations, :blocks

    # get a list of all rooms
    def initialize
      @rooms = make_rooms
      @reservations = []
      @blocks = []
    end

    def new_reservation(name, checkin_date, checkout_date, room_number)
      if rooms_available(checkin_date, checkout_date).any? { |room| room.number == room_number }
        reservation = Reservation.new({ name: name, checkin: checkin_date, checkout: checkout_date, room: room_number })

        reservations << reservation
      else
        raise ArgumentError.new("Room is not available for those dates.")
      end
    end

    def new_block(name, checkin_date, checkout_date, num_of_rooms, discount)
      case
      when num_of_rooms > 5
        raise ArgumentError.new("Maximum number of rooms for a block is 5")
      when num_of_rooms > rooms_available(checkin_date, checkout_date).length
        raise ArgumentError.new("There are not enough rooms available for these dates")
      else
        block_rooms = rooms_available(checkin_date, checkout_date).first(num_of_rooms)

        block = Block.new({ name: name, checkin: checkin_date, checkout: checkout_date, room: block_rooms, discount: discount })

        blocks << block
      end
    end

    def reserve_from_block(block_name, room_number, name)
      block_index = blocks.find_index { |block| block.name == block_name.downcase }
      block = blocks[block_index]

      reserv = Block.new({ name: name, checkin: block.checkin.strftime('%m-%d-%Y'), checkout: block.checkout.strftime('%m-%d-%Y'), rooms: room_number, discount: block.discount })

      reservations << reserv
      block.room.delete_if { |room| room.number == room_number }
    end

    def reservations_on(date)
      check_date = Date.strptime(date, '%m-%d-%Y')

      reservations.select { |reserv| check_date >= reserv.checkin && check_date < reserv.checkout }
    end

    def blocks_on(date)
      check_date = Date.strptime(date, '%m-%d-%Y')

      blocks.select { |block| check_date >= block.checkin && check_date < block.checkout }
    end

    def block_rooms_avail(block_name)

    end

    def rooms_available(checkin_date, checkout_date)
      rooms.reject { |room| booked_rooms(checkin_date, checkout_date).include?(room.number) }
    end

    def booked_rooms(checkin_date, checkout_date)
      checkin = Date.strptime(checkin_date, '%m-%d-%Y')
      checkout = Date.strptime(checkout_date, '%m-%d-%Y')
      booked_rooms = []

      checkin.upto(checkout) do |date|
        booked_rooms << reservations_on(date.strftime('%m-%d-%Y')).collect { |reserv| reserv.room }
        booked_rooms << blocks_on(date.strftime('%m-%d-%Y')).collect { |block| block.room.collect { |room| room.number } }
      end

      booked_rooms.flatten.uniq
    end

    private
    def make_rooms
      rooms = []
      i = 0
      NUMBER_OF_ROOMS.times do
        rooms << Room.new(i + 1)
        i += 1
      end

      rooms
    end
  end
end
