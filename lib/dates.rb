require 'awesome_print'
require 'date'

module Hotels
  # Contains the information pertinent to Dates
  class Dates
    def self.date_check?(checkin, checkout)
      if checkout.nil?
        Dates.past_date?(checkin)
      elsif checkout > checkin
        Dates.past_date?(checkin)
        Dates.past_date?(checkout)
      else
        raise ArgumentError, 'Invalid date range'
      end
    end # returns true or flags error that checkin/checkout dates are invalid

    def self.past_date?(date)
      today = Date.today
      raise ArgumentError, 'Date #{date} has already passed' if today > date
    end # flags error if the input date is earlier than current date

    def self.add_dates(array, checkin, checkout = nil, marker = 0)
      Dates.date_check?(checkin, checkout)
      if checkout.nil?
        array << checkin
      else
        count = (checkout - checkin).to_i + 1
        count = (checkout - checkin).to_i if marker.zero?
        count.times do
          array << checkin
          checkin += 1
        end
      end
    end # adds dates in between (checkin) and (checkout) to the (array)
  end # Dates class
end # Hotels module
