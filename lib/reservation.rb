require 'pry'
require_relative 'date_range'
#require_relative 'reservation_list'

module Hotel
  class Reservation

    attr_reader :id, :room, :check_in, :check_out, :date_range, :total_cost, :length_of_stay

    def initialize(id, room, day_in, day_out)
      @id = id
      @room = room
      @check_in = DateRange.check_in(day_in)#day_in
      @check_out = DateRange.check_out(day_out)#day_out
      @date_range = DateRange.create_range(@check_in, @check_out)
      @length_of_stay = @date_range.length - 1
      @total_cost = (200 * @length_of_stay).to_i
    end

    def view_reservation
      return "ID: #{@id}, Room: #{@room}, Check in: #{@check_in}, Check Out: #{@check_out}, Total Nights: #{@length_of_stay}, Total Cost: #{@total_cost}"
    end
  end #class


  # An InstructorTeam represents a collection of instructors

end #module

# liberal_arts_dept = InstructorTeam.new
# 6.times do |i|
#   liberal_arts_dept.add
# end
#
# puts "#{liberal_arts_dept.reservations.length} liberal arts teachers"
# # => 6 liberal arts teachers
#
# science_dept = InstructorTeam.new
# 10.times do
#   science_dept.add
# end
#
# puts "#{science_dept.instructors.length} science teachers"
# # => 10 science teachers
# puts "#{science_dept.instructors.inspect}"
#binding.pry
#maybe checkin and checkout are entered from daterange
#total cost of res.$
#dates of reservation
#room number
#get_total()
#id/name
