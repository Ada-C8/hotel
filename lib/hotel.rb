
#mark with x when done


# x I can access the list of all of the rooms in the hotel
# x I can reserve a room for a given date range
# x I can access the list of reservations for a specific date
# x I can get the total cost for a given reservation

# x number of rooms numbered 1-20
# x cost 200/night/rooms
# x make sure only charged for when occupied, not check out
# x error for invalid date range

# x I can view a list of rooms that are not reserved for a given date range
# x I can reserve an available room for a given date range
# x also, A reservation is allowed start on the same day that another reservation for the same room ends
# x should raise an exception when asked to reserve a room that is not available

require 'date'

module Hotel

  class DateRange

    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)

      @start_date = start_date
      @end_date = end_date #should this be under the if as an else?

      if @start_date > @end_date
        raise ArgumentError, "Start date cannot come after end date"
      end
    end



    # add in the comp date and such for this logic
    #def self.overlapping?(start_date, end_date, comparison_start_date, comparison_end_date)
      # start date is within comparison date range
      # return true if start_date >= comparison_start_date && start_date < comparison_end_date
      # end date is within comparison date range
    #   return true if end_date >= comparison_start_date && end_date <= comparison_end_date
    #   return false
    # end


  end #end of class DateRange

  class Reservation
    attr_reader :room_number, :start_date, :end_date, :cost

    def initialize(room_number, date, cost=200)
      @room_number = room_number
      @start_date = date.start_date
      @end_date = date.end_date


      if date.start_date == date.end_date
        @cost = cost
      else
        @cost = cost * (@end_date - @start_date).to_i
      end
    end


  end #end of class Reservations







  class Room

    attr_reader :room_number, :id, :rate

    def initialize(room_number)
      @room_number = room_number
      @id = id
      @rate = rate
    end

    # this was moved/refactored to hotelreservations
    # def self.all
    #   rooms = []
    #   number = 0
    #   20.times do
    #     number += 1
    #     rooms << self.new(number)
    #   end



  end #end of class rooms

  class Block_Of_Rooms < Room
    attr_reader :available_rooms, :date, :room_booked, :id

    def initialize(rooms, date, id)
      @available_rooms = rooms
      @room_booked = []
      @id = id
      @available_rooms.length.times do |i|
        @room_booked << false
      end
      @date = date
      @cost = 175
    end
  end #end of block of rooms









  class ReservationSystem

    attr_reader :rooms, :room_reservation, :date_reserve, :block_rooms

    def initialize

      @rooms = []
      @room_reservation = {}
      @date_reserve = {}
      @block_rooms = []

      @blocked_rooms = []
      20.times do |r|
        @rooms << Hotel::Room.new(r)
        @room_reservation[r] = []
      end

    end

    def reservation(room_number, date)
      if @blocked_rooms.include?(room_number)
        @block_rooms.each do |block|
          block.rooms.each do |current_room_in_block|
            if current_room_in_block.room_number == room_number
              if date.start_date > current_block.start_date &&
                date.start_date < current_block.end_date
                raise ArgumentException, "This is part of a block. Change start date"
              elsif date.end_date > current_block.start_date
                raise ArgumentException, "This is part of a block. Change your end date"
              end
            end
          end
        end
      end

      #still in reservation method :)

      current_res = @room_reservation[room_number]
      current_res.each do |r|
        if date.start_date < r.start_date
          if (date.end_date - r.start_date).to_i > 0
            raise ArgumentError, "Room is unavailable"
          end
        elsif date.start_date == r.start_date || (date.start_date - r.end_date).to_i < 0
          raise ArgumentError, "Room is unavailable"
        end
      end

      new_reservation = Hotel::Reservation.new(room_number, date)
      @room_reservation[room_number] << new_reservation
      if @date_reserve.key?(date.start_date)
        @date_reserve[date.start_date] << new_reservation
      else
        @date_reserve[date.start_date] = [new_reservation]
      end

    end

      def get_all_rooms
        return @rooms
      end

      def get_open_rooms(date)
        open_rooms = []
        20.times do |i|
          open_rooms[i] = true
        end

        current_date = date.start_date
        while current_date < date.end_date do
          if @date_reserve.key?(current_date)
            current_reservations = @date_reserve[current_date]
            current_reservations.each do  |this_reservation|
              open_rooms[this_reservation.room_number] = false
            end
          end
          current_date += 1
        end

        available_rooms = []
        index = 0

        open_rooms.each do |roomy|
          if roomy == true
            available_rooms << @rooms[index]
          end
          index += 1
        end

        return available_rooms
      end


      def make_new_block(number_of_rooms, date, id)
        available_rooms = get_open_rooms(date)
        if number_of_rooms > 5
          raise ArgumentException, "Sorry, only selection of up to 5 rooms is allowed"
        elsif number_of_rooms > available_rooms.length
          raise ArgumentException, "Only #{available_rooms.length} are available for the chosen dates"
        else
          rooms = []
          number_of_rooms.times do |i|
            rooms << available_rooms[i]
            @blocked_rooms << available_rooms[i]
          end
          new_block = Hotel::Block_Of_Rooms.new(rooms, date, id)
          @block_rooms << new_block
        end
      end

      #not testing correctly - possible issues with naming (confusing names)
      def check_block_for_availablity(block_id)
        @block_rooms.each do |block|
          if block.id == block_id
            block.room_booked.each do |is_room_booked|
              if is_room_booked == false
                return true
              end
            end
          end
        end

        return false
      end
#add back in comments if adding a discounted rate
      def reserve_room_from_block(block_id)
        if @block_rooms == []
          raise ArgumentError, "No current room blocks available"
        # else
        #   @block_rooms.each do |current_block|
        #     if current_block.id == block_id
        #       if check_block_for_availablity(block_id)
                #room = get_open_room_from_block(current_block)
                #new_reservation = Hotel::Reservation.new(room, current_block.date, 180)
              else
                return "No availability"

              # end
            # end
          # end
        end
      end


    # end











  end #end of class ReservationSystem

end #end of module hotel
