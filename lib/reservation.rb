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
        too_old(checkin)
        @dates << checkin
      elsif checkout > checkin
        too_old(checkin)
        too_old(checkout)
        shovel_dates(checkin, checkout)
      else
        raise ArgumentError
      end
    end # add_dates method

    def shovel_dates(checkin, checkout)
      (checkout - checkin).to_i.times do
        @dates << checkin
        checkin += 1
      end
    end # shovel_dates method

    def too_old(date)
      today = Date.today
      raise ArgumentError if today > date
    end # too_old method

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
