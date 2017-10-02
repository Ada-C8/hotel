require_relative 'Reservation'

module HotelBooking
  class BlockReservation < HotelBooking::Reservation
    attr_accessor :id, :guest, :check_in, :check_out, :room, :block_id
    attr_reader :all_reservations, :type

    def initialize(check_in,check_out,room_id, b_res_id, block_discount, guest = nil)
      super(check_in,check_out,room_id, b_res_id,block_discount, guest = nil)
      @rate = block_discount
      @block_id = nil
      @type= :block
    end #end initialize

    def cost
     num_nights_charged * @rate
    end
  end
end
