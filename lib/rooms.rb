require_relative 'hotel.rb'
require 'date'

class Room
  attr_accessor :id, :rate, :status

  def initialize(id, rate: 200, status: :available)
    if id.class != Integer || rate.class != Integer
      raise ArgumentError.new("ID and rate must be entered as integers.")
    end

    @id = id
    @rate = rate

    unless status == :available || status == :booked || status == :blocked
      raise ArgumentError.new("Rooms may only have a status of :available, :booked, or :blocked.")
    end

    @status = status
  end

end
