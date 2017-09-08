require_relative 'reservation'
require_relative './concerns/dateable'
require 'date'
require 'pry'
module Hotel


  class Block < Reservation
    include Hotel::Dateable::InstanceMethods


    attr_accessor :date_range, :room, :name, :contact_info, :check_in, :check_out, :price, :discount

    def  initialize(check_in, check_out, room = "TBD", name, contact_info, discount)

      super(check_in, check_out, room, name, contact_info)
      @discount = calculate_discount(discount)
      @price = (@date_range.length) * PRICE_PER_NIGHT * @discount
    end

    def calculate_discount(number)
      (100 - number) * 0.01
    end

    def change_discount(discount)
      @discount = calculate_discount(discount)
    end

  end
end
