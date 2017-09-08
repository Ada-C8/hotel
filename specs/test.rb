require 'date'
require_relative 'spec_helper'
hotel1 = Hotel::Reservations.new
checkin = Date.new(2017,9,5)
checkout = Date.new(2017,9,7)
hotel1.make_booking(checkin, checkout)
hotel1.make_block(checkin, checkout, 4, "wedding")
binding.pry
puts hotel1
