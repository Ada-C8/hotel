require 'awesome_print'
require 'date'
require_relative 'room'

module Hotels
  # Contains the information pertinent to Reservations
  class Reservation
    attr_accessor :id, :block_id, :rooms, :dates, :total_cost

    def initialize(checkin, checkout = nil)
      @id = 0
      @block_id = 0
      @dates = []
      @rooms = []
      add_dates(checkin, checkout)
      @total_cost = 0
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

    def calc_total
      if block_id.zero?
        nights_charged = @dates.length * @rooms.length
        @total_cost = Hotels::Room::REGULAR_RATE * nights_charged
      end
      # elsif block_id > 0
      # @total_cost = Hotels::Room::BLOCK_RATE * nights_charged
    end # calc_total method
  end # Reservation class
end # Hotels module
