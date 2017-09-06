require_relative 'date_range'
module My_Hotel
  class Reservation

    attr_accessor :reservation_id, :block_id, :room_number, :cost, :date_range


    def initialize(start_date,end_date)
      @start_date = start_date
      @end_date = end_date
      @reservation_id = nil
      @cost = nil
      @room_number = nil
      @date_range = My_Hotel::Date_Range.new(@start_date, @end_date).nights
      @block_id = []

    end

    # def self.set_id
    #   reservation_id = 1 if Hotel.list_of_reservations == nil
    #   reservation_id = Hotel.list_of_reservations.length + 1 if Hotel.list_of_reservations != nil
    # end




    # def set_id(hotel)
    #   @reservation_id =[]
    #   unique = false
    #   while unique == false #while reservation_id is not unique
    #     unique = true
    #     1.times do @reservation_id << rand(9) #make new reservation_id
    #       hotel.list_of_reservations.each do |reservation| #check if unique
    #         if reservation.reservation_id == @reservation_id
    #           unique = false
    #         end
    #       end
    #     end
    #   end
    # end


    def cost_reservation
      number of dates * Room.rate = sum
    end

    # def cancel_reservation
    # end

    # def confirm
    #   # My_Hotel::Hotel.list_of_reservations << My_Hotel::Reservation
    # end

  end
end

# h = My_Hotel::Hotel.new
# a = h.make_reservation([2017,1,2], [2017,1,5])
# b = h.make_reservation([2017,2,2], [2017,2,5])
# puts a.reservation_id
# puts b.reservation_id
