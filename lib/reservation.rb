module Hotel
  class Reservation
    attr_reader :id
    def initialize(id)
      @id = id
    end

    # def reserve_room(date_range, hotel)
    #   @date_range = date_range
    #   hotel.reservations << self
    # end

    def reserve_room(date_range, hotel)
      # reserve a room for a given date range
      # reservation = {}
      # reservation[@id] = date_range
      @date_range = date_range
      hotel.reservations << self
      # call new instance of hotel in Booker class
    end

    def access_reservations
      # access the list of reservations for a specific date
      # returns @reservations
    end

    def get_total
      # get the total cost for a given reservation
    end

  end

end
# @words = {}
#
#     CSV.open("words.csv", 'r').each do |line|
#       # sets first value to key and line to value
#       @words[line.shift] = line
#     end
