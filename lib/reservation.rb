module BookingSystem
  class Reservation
    attr_reader :id, :dates

    def initialize(check_in, check_out)
      @id = nil # Do we need an id? Do we actually use this later on?
      @dates = DateRange.new(check_in, check_out)
    end

  end # Reservation
end # BookingSystem
