module Hotel
  class Hotel

    attr_reader :reservations, :rooms

    def initialize
      @reservations = [] #where reservation objects are pushed
      @rooms = {room1:200, room2:200, room3:200, room4:200, room5:200, room6:200, room7:200,
        room8:200, room9:200, room10:200} #roomnumber:price
        #CHANGE ROOMS TO CONSTANT??
      end

      def make_reservation(id, date1, *date2, room_number, cost)
        reservation = Reservation.new(id, date1, *date2, room_number, cost)
        @reservations << reservation
      end

      def view_available(date1, *date2)
        available = [:room1, :room2, :room3, :room4, :room5, :room6, :room7, :room8, :room9, :room10,
          :room11, :room12, :room13, :room14, :room15, :room16, :room17, :room18, :room19, :room20]
          thisdaterange = DateRange.new(date1, *date2)
          @reservations.each do |reservation|
            if reservation.daterange.overlap?(thisdaterange)
              available.delete(reservation.room_number) #remove reservation.room_number from available
            end
          end
          return available
        end


        def view_booked(date1, *date2)
          booked = []
          thisdaterange = DateRange.new(date1, *date2)
          @reservations.each do |reservation|
            if reservation.daterange.overlap?(thisdaterange)
              booked << reservation.room_number #remove reservation.room_number from available
            end
          end
          return booked
        end

        def is_available?(room_number, date1, *date2)
          thisdaterange = DateRange.new(date1, *date2)
          @reservations.each do |reservation|
            if reservation.daterange.overlap?(thisdaterange) && reservation.room_number == room_number
              return false
            end
          end
          return true
        end


      end #end of class
    end #end of module
