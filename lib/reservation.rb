require_relative 'date_range'
require 'csv'

module BookingSystem
  class Reservation

    @@id_count = 1

    attr_reader :id, :date_range, :room, :cost, :total_cost

    def initialize(date_range, room, cost)

      @id = @@id_count
      @@id_count += 1
      @date_range = date_range
      @room = room
      @cost = cost
      @total_cost = (cost * date_range.dates_within_range.length).to_f

    end #end of initialize

    #method seems to be working fine, but don't have any tests for loading data back
    def add_reservation(file)
      CSV.open(file, "a") do |line|
        line << ["#{self.id}","#{self.room}","#{self.date_range.check_in.strftime("%m/%d/%Y")}","#{self.date_range.check_out.strftime("%m/%d/%Y")}","#{self.total_cost}"]
      end
    end #end of method

  end #end of class

end #end of module
