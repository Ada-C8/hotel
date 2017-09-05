
require_relative 'room'

module Hotel

  class Building
    attr_reader :rooms

    def initialize
      @rooms = [] #NOTE As an administrator, I can access the list of all the rooms in the hotel"

      20.times do |num|
        @rooms << Hotel::Room.new(num + 1)
      end
    end

  end # Building class

  this_hotel = Building.new #TODO 4 decide where to put this instantiation
  
end # Hotel module
