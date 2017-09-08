module Property

  class Block
    # make sure to uncomment block in spec helper

    attr_reader :rooms, :check_in, :check_out, :price

    def initialize(rooms,check_in,check_out,price)

      raise ArgumentError.new "Cannot accomodate block reservation
      for more than five rooms at a time." if rooms.length > 5

      raise ArgumentError.new "Must specify at least one room." if rooms.empty?

        @availability = rooms.clone
        @rooms = []
        @dates = Property::Range.new(check_in, check_out)
        @price = 200
        @total_price = @dates.num_nights * @price * @rooms.length
      end

      def reserve_individual_room(room)
        raise ArgumentError.new "No availability" if @availability.empty?
        @vailability.pop(room)
        @availability << room
        retun room
      end

    end
  end



  # block = {
  #   rooms => [],
  #   check_in => check_in,
  #   check_out => check_out,
  #   total_price => ((rooms.length * 200)*(check_out - check_in))
  # }
