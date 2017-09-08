require_relative 'date_range'
module My_Hotel
  class Block

    attr_reader :first_night, :last_night, :room_numbers, :nights_booked, :discount, :block_id

    def initialize(first_night, last_night, array_of_rooms, discount)
      @first_night = first_night
      @last_night = last_night
      @discount = discount
      @room_numbers = array_of_rooms
      @nights_booked = My_Hotel::Date_Range.new(first_night,last_night)
      @block_id = nil
      #@contact_info #could add contact_info
    end

    def set_block_id
      new_block_id = ""
      4.times do
        new_block_id = new_block_id + (rand(9)).to_s
      end
      @block_id = new_block_id
    end

    # def assign_room(rooms_available_in_block)
    #   if rooms_avail.length != 0
    #     @room_number = rooms_avail.keys.sample
    #   else
    #     raise ArgumentError.new("Can't make reservation, there are no rooms available in that block: #{@first_night} to #{@last_night} in block id #{block_id}")
    #   end
    # end


  end
end
