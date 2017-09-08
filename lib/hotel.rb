

require 'errors'
require 'pry'

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


#REFACTOR SO IF MAKING BLOCK RES YOU DON'T HAVE TO SPECIFY DATES
      def make_reservation(date1=nil, date2=nil, partyname = nil)
        unless partyname == nil
          id = reservations.length + 1
          @blocks.each do |block|
            if block.partyname == partyname
              date1 = block.daterange.beginning
              date2 = block.daterange.ending
              cost = block.discountedrate
              puts "PARTYNAME: #{partyname}"
              block.rooms.each do |room|
                if is_available?(room, date1, date2, partyname)
                  reservation = Reservation.new(id, room, cost, date1, date2, partyname)
                  @reservations << reservation
                  return @reservations
                end
              end
              raise BookingError.new('There are no rooms available in that block')
            end
          end
        end
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
        @block_available
      end

      def view_available(date1, date2=nil)
        available = []
        thisdaterange = DateRange.new(date1, date2)
        @rooms.each do |room|
          if is_available?(room, date1, date2)
            available << room
          end
        end
        return available
      end


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
        block_rooms = []
        index = 0
        if number_rooms > 5
          raise BookingError.new('You may only block off five rooms at a time')
        end
        until block_rooms.length == number_rooms #|| block_rooms.length == 5
          if is_available?(@rooms[index], date1, date2)
            block_rooms << @rooms[index]
          end
          index += 1
          if index > 20
            raise BookingError.new('There are no rooms available to make a block')
          end
        end
        current_block = Block.new(partyname, discountedrate, block_rooms, date1, date2=nil)
        @blocks << current_block
      end


    end #end of class
  end #end of module




# require 'errors'
# # require 'pry'
#
# module Hotel
#   class Hotel
#
#     attr_reader :reservations, :rooms, :blocks
#
#     def initialize
#       @reservations = [] #where reservation objects are pushed
#       @rooms = [:room1, :room2, :room3, :room4, :room5, :room6, :room7, :room8, :room9, :room10,
#         :room11, :room12, :room13, :room14, :room15, :room16, :room17, :room18, :room19, :room20] #roomnumber:price
#         #CHANGE ROOMS TO CONSTANT??
#         @blocks = []
#       end
#
#       def make_reservation(date1, date2 = date1) #name = nil)
#         if view_available(date1, date2=nil).length != 0
#           room_number = view_available(date1, date2=nil)[0]
#           cost = 200
#           id = @reservations.length + 1
#           reservation = Reservation.new(id, date1, date2=nil, room_number, cost)
#           @reservations << reservation
#         else
#           raise BookingError.new("No rooms available during daterange selected")
#         end
#       end
#
#       # def make_block_reservation(date1, *date2, room_number, cost, partyname)
#       #   @blocks.each do |block|
#       #     if block.name == name
#       #       reservation = Reservation.new(id, date1, *date2, room_number, cost, partyname)
#       #     end
#       #   end
#       # end
#
#
#
#       def view_available(date1, date2 = date1)
#         available = []
#         thisdaterange = DateRange.new(date1, date2=nil)
#         @rooms.each do |room|
#           if is_available?(room, date1, *date2)
#             available << room #remove reservation.room_number from available
#           end
#         end
#
#         # @reservations.each do |reservation|
#         #   if reservation.daterange.overlap?(thisdaterange)
#         #     available.delete(reservation.room_number) #remove reservation.room_number from available
#         #   end
#         # end
#         return available
#       end
#
#
#       def view_booked(date1, date2=nil)
#         booked = []
#         thisdaterange = DateRange.new(date1, date2=nil)
#         @reservations.each do |reservation|
#           if reservation.daterange.overlap?(thisdaterange)
#             booked << reservation.room_number #remove reservation.room_number from available
#           end
#         end
#         return booked
#       end
#
#       def is_available?(room_number, date1, date2=nil)
#         thisdaterange = DateRange.new(date1, date2=nil)
#         @reservations.each do |reservation|
#           if reservation.daterange.overlap?(thisdaterange) && reservation.room_number == room_number
#             return false
#           end
#         end
#
#         @blocks.each do |block|
#           if block.rooms.include? room_number
#             if block.daterange.overlap? thisdaterange
#               return false
#             end
#           end
#         end
#         return true
#       end
#
#       def make_block(partyname, date1, date2=nil, discounted_rate, number_rooms)
#         block_rooms = []
#         index = 0
#         if number_rooms > 5
#           raise BookingError.new('You may only block off five rooms at a time')
#         end
#         # binding.pry
#         until block_rooms.length == number_rooms || block_rooms.length == 5
#           if is_available?(@rooms[index], date1, date2=nil)
#             block_rooms << @rooms[index]
#           end
#           index += 1
#           if index > 20
#             raise BookingError.new('There are no rooms available to make a block')
#           end
#         end
#         thisblock = Block.new(partyname, date1, date2=nil, discounted_rate, block_rooms)
#         @blocks << thisblock
#       end
#       # puts @blocks
#
#     end #end of class
#   end #end of module
