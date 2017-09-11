require_relative 'reservation'
require_relative './concerns/dateable'
require 'date'
require 'pry'
module Hotel


  class Block < Reservation
    include Hotel::Dateable::InstanceMethods


    attr_accessor :date_range, :room, :name, :contact_info, :check_in, :check_out, :price, :discount, :num_rooms

    def  initialize(check_in, check_out, name, contact_info, discount, num_rooms)

      super(check_in, check_out, room, name, contact_info)
      @discount = discount
      @price = (@date_range.length) * PRICE_PER_NIGHT * calculate_discount(@discount)
      @num_rooms = num_rooms
    end

    def change_discount(discount)
      @discount = calculate_discount(discount)
    end

    def price_all_rooms
      @num_rooms * @price
    end

    def change_rooms_block(number)
      @num_rooms = number
    end

    private


    def calculate_discount(number)
      (100 - number) * 0.01
    end
  end
end
