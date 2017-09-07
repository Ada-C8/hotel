require_relative 'room'
require_relative 'reservation'
require 'date'

class Hotel
  attr_reader :rooms, :reservation_by_room, :reservation_by_date

  def initialize
    @rooms = []
	@reservations_by_room = {}
	@reservations_by_date = {}
	20.times do |i|
		@rooms << Room.new(i)
		@reservations[i] = []
	end
	
  end
  
  
  
end

date1 = Date.new(2007,1,1)
date2 = Date.new(2008,5,2)
print (date2 - date1).to_i