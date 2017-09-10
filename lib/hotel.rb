require_relative 'reservation'
require_relative 'block'

module Hotel

  class Hotel

    attr_reader :rooms, :price, :reservation_collection, :block_reservation_collection, :reservation_made

    def initialize(num_of_rooms, price)
      @rooms = []
      room_num = 0
      num_of_rooms.times do |room|
        room_num += 1
        @rooms << room_num
      end #loop

      @price = price
      @reservation_collection = []
      @block_reservation_collection = []
    end #initialize

    def make_reservation(check_in, check_out, room_num)
      if room_availability(check_in, check_out).include?(room_num)
        puts "Reservation made"
        @reservation_made = Reservation.new(check_in, check_out, room_num)
        @reservation_collection << @reservation_made
      else
        raise ArgumentError.new("It appears the room you requested is booked during that date range")
      end
      # @reservation_collection << @reservation_made
    end


    def make_block_reservation(check_in, check_out, num_of_rooms)
      if room_availability(check_in, check_out).length >= num_of_rooms
        puts "we can create a block reservation"
        @block_reservation = Block.new(check_in, check_out, num_of_rooms, client, discount, client, cost)
      else
        puts "appears we can't block rooms for you at this point"
      end
    end



    def date_list_of_reservations(date)
      date_list = []
      date = Date.parse(date)
      @reservation_collection.each do |entry|
        # binding.pry
        if entry.check_in <= date && entry.check_out >= date
          date_list << [entry.room_num, entry.check_in.to_s, entry.check_out.to_s]
        end
      end
      return date_list
    end #def


    def room_availability(check_in, check_out)
      #can be string with dates
      rooms_available = @rooms.clone

      # [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      check_in = Date.parse(check_in)
      check_out = Date.parse(check_out)

      if check_in > check_out
        raise ArgumentError.new("Invalid date range")
      end

      @reservation_collection.each do |entry|
        if check_in < entry.check_in && check_in < entry.check_out && check_out < entry.check_out && check_out > entry.check_in
          rooms_available.delete(entry.room_num)
        elsif check_in > entry.check_in && check_in < entry.check_out && check_out < entry.check_out && check_out > entry.check_in
          rooms_available.delete(entry.room_num)
        elsif check_in > entry.check_in && check_in < entry.check_out && check_out == entry.check_out && check_out > entry.check_in
          rooms_available.delete(entry.room_num)
        elsif check_in < entry.check_in && check_in < entry.check_out && check_out > entry.check_in && check_out == entry.check_out
          rooms_available.delete(entry.room_num)
        elsif check_in > entry.check_in && check_in < entry.check_out && check_out > entry.check_out
          rooms_available.delete(entry.room_num)
        elsif check_in == entry.check_in && check_in < entry.check_out && check_out > entry.check_in && check_out > entry.check_in
          rooms_available.delete(entry.room_num)
        end
      end

      @block_reservation_collection.each do |entry|
        if check_in < entry.check_in && check_in < entry.check_out && check_out < entry.check_out && check_out > entry.check_in
          rooms_available.delete(entry.room_num)
        elsif check_in > entry.check_in && check_in < entry.check_out && check_out < entry.check_out && check_out > entry.check_in
          rooms_available.delete(entry.room_num)
        elsif check_in > entry.check_in && check_in < entry.check_out && check_out == entry.check_out && check_out > entry.check_in
          rooms_available.delete(entry.room_num)
        elsif check_in < entry.check_in && check_in < entry.check_out && check_out > entry.check_in && check_out == entry.check_out
          rooms_available.delete(entry.room_num)
        elsif check_in > entry.check_in && check_in < entry.check_out && check_out > entry.check_out
          rooms_available.delete(entry.room_num)
        elsif check_in == entry.check_in && check_in < entry.check_out && check_out > entry.check_in && check_out > entry.check_in
          rooms_available.delete(entry.room_num)
        end
      end
      return rooms_available
    end #room_availability

  end #class
end #module


### second round of logic ### does not work because it will list rooms that are available for a given date range and not couple if the room is taken for another date


#   if check_in == entry.check_in && check_in < entry.check_out && check_out > entry.check_in && check_out < entry.check_out
#     false
#     binding.pry
#
#   elsif check_in< entry.check_in && check_out == entry.check_in && check_in < entry.check_out
#     rooms_available << entry.room_num
#   # elsif check_in < entry.check_in && check_in < entry.check_out && check_out == entry.check_in
#   #   rooms_available << entry.room_num
#   elsif check_in == entry.check_out && check_out > entry.check_out
#     rooms_available << entry.room_num
#   elsif check_in > entry.check_out
#     rooms_available << entry.room_num
#   # elsif check_in < entry.check_in && check_out < entry.check_in && check_in < entry.check_out
#   #   rooms_available << entry.room_num
#   end
