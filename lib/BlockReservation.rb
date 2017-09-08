
require_relative 'Block'
require_relative 'Reservation'
require_relative 'Booking'

module Hotel
  class BlockReservation < Hotel::Reservation
    attr_accessor :id, :guest, :check_in, :check_out, :room, :block_id
    attr_reader :all_reservations, :type

    def initialize(check_in,check_out,room_id, b_res_id, block_discount,guest = nil)
      super(check_in,check_out,room_id, b_res_id,block_discount, guest = nil)
      #how do I incorporate a block id?
      @discounted_rate = block_discount
      @block_id = nil
      @type= :block
    end #end initialize

    def cost
     num_nights_charged * @discounted_rate
    end
  end
end

#can I additional parameter block_id, and still use super to inherit from Reservation
