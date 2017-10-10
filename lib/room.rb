require 'date'

module Hotel
  class Room
    def initialize(price = 200)
      @price = price.to_f
    end
    # def booked?(arrival, departure)
    #   arrival = Date.strptime('03-02-2001', '%m-%d-%Y')
    #   departure =                   Date.strptime('03-02-2001', '%m-%d-%Y')
    # end
  end
end
