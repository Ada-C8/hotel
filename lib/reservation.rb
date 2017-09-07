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
      calc_total
    end

    def add_dates(checkin, checkout)
      if checkout.nil?
        too_old(checkin)
        @dates << checkin
      elsif checkout > checkin
        too_old(checkin)
        too_old(checkout)
        Reservation.shovel_dates(checkin, checkout, @dates)
      else
        raise ArgumentError
      end
    end # adds 1 or more valid Dates to a reservation

    def too_old(date)
      today = Date.today
      raise ArgumentError if today > date
    end # checks if the selected date is older than the current date

    def calc_total
      # W1-C3 Guest should not be charged for the last day
      nights_charged = @dates.length * @rooms.length
      if @block_id.to_i <= 0
        @total_cost = Hotels::Room::REGULAR_RATE * nights_charged
      else
        @total_cost = Hotels::Room::BLOCK_RATE * nights_charged
      end
    end # changes the value of total cost depending on nightly rate

    def self.shovel_dates(checkin, checkout, array, mark = 0)
      count = (checkout - checkin).to_i + 1
      count = (checkout - checkin).to_i if mark.zero?
      count.times do
        array << checkin
        checkin += 1
      end
    end # adds multiple Dates to an Array
  end # Reservation class
end # Hotels module
