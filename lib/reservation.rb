module Hotel
  class Reservation
    attr_reader :checkin, :checkout, :days_range
    def initialize(checkin, checkout)#, room_number)
      @price_per_night = 200
      @days_range = Hotel::DateRange.new(checkin, checkout)
      # @rooms = {}
      # 20.times do |i|
      #   @rooms["#{i + 1}"] => []
      # end
    end

    def totalcost
      @price_per_night * @days_range.stay_length
    end

    # def room_avaliables(@days_range)
    #
    # end




  end #class Reservation
end
