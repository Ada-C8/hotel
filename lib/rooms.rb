require_relative 'hotel.rb'
require 'date'

# Does this ever need to be touched again?  Is it okay that it exists solely for the purpose of creating a single room object?  Or should it be folded in as a method into the hotel class?

class Room
attr_accessor :id, :rate, :status

  def initialize(id, rate: 200, status: :available)
    @id = id
    @rate = rate
    @status = status
  end

end
