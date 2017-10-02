require_relative 'reservation'

module Hotel
  class Block < Reservation
    attr_accessor :status

    def initialize(start_date, end_date)
      super(start_date, end_date)
      @status = :available
    end
  end
end
