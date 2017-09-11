module Property

  class Block < Range

    attr_reader :rooms, :price, :availability, :reservations

    def initialize(rooms, check_in, check_out, price)

      raise ArgumentError.new "Cannot accomodate block reservation
      for more than five rooms at a time." if rooms.length > 5
      raise ArgumentError.new "Must specify at least one room." if rooms.empty?
        super(check_in, check_out)
        @rooms = []
        @available = rooms.clone
        @reservations = []
        @price = 150  #discounted
      end

      def reserve_block(room)
        raise ArgumentError.new "No availability" if @availability.empty?
        reservation = @available.pop(room)
        @reservations << reservation
        return reservation
      end
    end
  end
