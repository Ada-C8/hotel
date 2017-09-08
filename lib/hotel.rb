

require 'errors'
# require 'pry'

module Hotel
  class Hotel

    attr_reader :reservations, :rooms, :blocks

    def initialize
      @reservations = [] #where reservation objects are pushed
      @rooms = [:room1, :room2, :room3, :room4, :room5, :room6, :room7, :room8, :room9, :room10,
        :room11, :room12, :room13, :room14, :room15, :room16, :room17, :room18, :room19, :room20] #roomnumber:price
        #CHANGE ROOMS TO CONSTANT??
      @blocks = []
    end

      def make_reservation(date1: nil, date2: nil, partyname: nil)
        unless partyname == nil
          make_block_reservation(date1, date2, partyname)
        else
          if view_available(date1, date2).length != 0
            room_number = view_available(date1, date2)[0]
            cost = 200
            id = @reservations.length + 1
            reservation = Reservation.new(id, room_number, cost, date1, date2)
            @reservations << reservation
          else
            raise BookingError.new("No rooms available during daterange selected")
          end
        end
      end

      def make_block_reservation(date1, date2, partyname)
        id = reservations.length + 1
        @blocks.each do |block|
          if block.partyname == partyname
            date1 = block.daterange.beginning
            date2 = block.daterange.ending
            cost = block.discountedrate
            block.rooms.each do |room|
              if is_available?(room, date1, date2, partyname)
                reservation = Reservation.new(id, room, cost, date1, date2, partyname)
                @reservations << reservation
                return @reservations #can take out?
              end
            end
            raise BookingError.new('There are no rooms available in that block')
          end
        end
      end

      #REFACTOR SO IF MAKING BLOCK RES YOU DON'T HAVE TO SPECIFY DATES
      # def make_reservation(date1: nil, date2: nil, partyname: nil)
      #   unless partyname == nil
      #     id = reservations.length + 1
      #     @blocks.each do |block|
      #       if block.partyname == partyname
      #         date1 = block.daterange.beginning
      #         date2 = block.daterange.ending
      #         cost = block.discountedrate
      #         block.rooms.each do |room|
      #           if is_available?(room, date1, date2, partyname)
      #             reservation = Reservation.new(id, room, cost, date1, date2, partyname)
      #             @reservations << reservation
      #             return @reservations #can take out?
      #           end
      #         end
      #         raise BookingError.new('There are no rooms available in that block')
      #       end
      #     end
      #   end
      #   if view_available(date1, date2).length != 0
      #     room_number = view_available(date1, date2)[0]
      #     cost = 200
      #     id = @reservations.length + 1
      #     reservation = Reservation.new(id, room_number, cost, date1, date2)
      #     @reservations << reservation
      #   else
      #     raise BookingError.new("No rooms available during daterange selected")
      #   end
      # end


      #CHECK WHICH ROOMS IN A BLOCK available
      def view_available_in_block(partyname, date1, date2=nil)
        @block_available = []
        @blocks.each do |block|
          block.rooms.each do |room|
            if is_available?(room, date1, date2, partyname)
              @block_available << room
            end
          end
        end
        return @block_available
      end

      #AVAILABLE OUTSIDE OF BLOCKS ONLY?
      def view_available(date1, date2=nil)
        available = []
        # thisdaterange = DateRange.new(date1, date2)
        @rooms.each do |room|
          if is_available?(room, date1, date2)
            available << room
          end
        end
        return available
      end

      #USE MAP?
      def view_booked(date1, date2=nil)
        booked = []
        thisdaterange = DateRange.new(date1, *date2)
        @reservations.each do |reservation|
          if reservation.daterange.overlap?(thisdaterange)
            booked << reservation.room_number
          end
        end
        return booked
      end

      def is_available?(room_number, date1, date2=nil, partyname = nil)
        thisdaterange = DateRange.new(date1, date2)
        @reservations.each do |reservation|
          if reservation.daterange.overlap?(thisdaterange) && reservation.room_number == room_number
            return false
          end
        end
        is_in_block?(room_number, date1, date2, partyname, thisdaterange)
      end

      #IS THIS BETTER SEPARATED?
      def is_in_block?(room_number, date1, date2=nil, partyname = nil, thisdaterange)
        if partyname == nil
          @blocks.each do |block|
            if block.rooms.include? room_number
              if block.daterange.overlap? thisdaterange
                return false
              end
            end
          end
        end
        return true
      end

      def make_block(partyname, discountedrate, number_rooms, date1, date2=nil)
        raise BookingError.new('You may only block off five rooms at a time') if number_rooms > 5
        rooms_in_block = make_block_rooms(number_rooms, date1, date2)
        current_block = Block.new(partyname, discountedrate, rooms_in_block, date1, date2)
        @blocks << current_block
      end

      def make_block_rooms(number_rooms, date1, date2)
        rooms_in_block = []
        index = 0
        until rooms_in_block.length == number_rooms
          if is_available?(@rooms[index], date1, date2)
            rooms_in_block << @rooms[index]
          end
          index += 1
          raise BookingError.new('There are no rooms available to make a block') if index > 20
        end
        return rooms_in_block
      end

  end #end of class
end #end of module
