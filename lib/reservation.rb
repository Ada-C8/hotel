require 'awesome_print'
require 'date'

module Hotels
  class Reservation
    attr_accessor :id, :block_id, :rooms, :dates

    def initialize(checkin, checkout = nil)
      @id = 0
      @block_id = 0
      @dates = []
      @rooms = []

      if checkout == nil
        @dates << checkin
      elsif checkout > checkin
        (checkout - checkin).to_i.times do
          @dates << checkin
          checkin += 1
        end
      else
        raise ArgumentError
      end
    end

  end
end
