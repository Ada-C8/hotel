require 'csv'

module Hotel
  class Block < Reservation

  attr_reader :name, :checkin, :checkout, :room, :discount

    def initialize(args)
      super(args)
      @discount = args[:discount].to_f / 100
    end

    def cost
      super * (1 - discount)
    end
  end
end
