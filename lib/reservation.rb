require 'awesome_print'
require 'date'

module Hotels
  # Contains the information pertinent to Reservations
  class Reservation
    attr_accessor :id, :block_id, :rooms, :dates

    def initialize(checkin, checkout = nil)
      @id = 0
      @block_id = 0
      @dates = []
      @rooms = []
      add_dates(checkin, checkout)
    end # initialize method

    def add_dates(checkin, checkout)
      if checkout.nil?
        @dates << checkin
      elsif checkout > checkin
        (checkout - checkin).to_i.times do
          @dates << checkin
          checkin += 1
        end
      else
        raise ArgumentError
      end
    end # add_dates method
  end # Reservation class
end # Hotels module
