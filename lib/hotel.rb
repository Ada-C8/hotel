
module Hotel
  class Hotel
    attr_reader :reservations, :rooms

    def initialize
      @reservations = []
      @rooms = (1..20).to_a
    end # initialize
  end # end class
end # end module
