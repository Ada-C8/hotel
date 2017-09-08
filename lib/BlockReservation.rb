require_relative 'Block'
require_relative 'Reservation'
require_relative 'Booking'

module Hotel
  class BlockReservation < Hotel::Reservation
    def initialize(check_in,check_out,room_id, b_res_id, block_discount, block_id,guest = nil)
      super(check_in,check_out,room_id, b_res_id,block_discount, guest = nil)
      #how do I get the discounted_rate? must incorpo
      @discounted_rate = block_discount
      @block_id = block_id
      @type= :block 
    end #end initialize

    def cost
     num_nights_charged * @discounted_rate
    end
  end
end

#can I additional parameter block_id, and still use super to inherit from Reservation
