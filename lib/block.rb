module Hotel
  class Block < Reservation

  attr_reader :checkin, :checkout, :rooms, :discount

    def initialize(checkin_date, checkout_date, rooms, discount)
      super(checkin_date, checkout_date, rooms)
      @discount = discount.to_f / 100
    end
  end
end
