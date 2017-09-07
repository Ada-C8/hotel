require_relative 'spec_helper'

describe "Building" do
  # describe "initialize" do
  #   it "Creates an array of 20 rooms with room numbers" do
  #     ada_inn = Hotel::Building.new
  #
  #     ada_inn.rooms.must_be_kind_of Array
  #     ada_inn.rooms.length.must_equal 20
  #     ada_inn.rooms[0].must_be_instance_of Hotel::Room
  #     ada_inn.rooms[0].number.must_equal 1
  #     ada_inn.rooms[-1].number.must_equal 20
  #     ada_inn.rooms[300].must_be_nil
  #   end
  #
  # end
#
#   describe "search_date" do
#     it "Can list all reservations occuring on a specific date" do
#       #Reservation list will go through Rooms and pull up their reservations then sort by date. NOTE This seems like it is tied to Room class, but should be in rervations??
#       # Setup
#       ada_inn = Hotel::Building.new
#       date = '2017-06-12'
#       5.times do |i|
#         ada_inn.rooms[i + 1].reserve(date[0..-2] + 'i', i * 2)
#       end
#
#       date_to_check = '2017-02-17'
#
#       #Testing
#       Hotel::Building.search_date(date_to_check).must_be_kind_of Array
#       Hotel::Building.search_date(date_to_check)[0].must_be_instance_of Hotel::Reservation
#     end
#   end
# end

 #============== OLD WORK ====================#
   describe "initialize" do
     it "Creates an array of 20 rooms with room numbers" do
       ada_inn = ReservationSystem::Hotel.new

       ada_inn.hotel.must_be_kind_of Array
       ada_inn.hotel.length.must_equal 20
       ada_inn.hotel[0].must_be_instance_of ReservationSystem::Room
       ada_inn.hotel[0].number.must_equal 1
       ada_inn.hotel[-1].number.must_equal 20
       ada_inn.hotel[300].must_be_nil
     end

   end

end #"Building"
