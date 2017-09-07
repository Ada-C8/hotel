require_relative 'spec_helper'

describe "Hotel" do
  let(:ada_inn) { ReservationSystem::Hotel.new }

   describe "initialize" do
     it "Creates a hotel that is an array of 20 rooms with room numbers" do
       ada_inn.hotel.must_be_kind_of Array
       ada_inn.hotel.length.must_equal 20

       ada_inn.hotel[0].must_be_instance_of ReservationSystem::Room
       ada_inn.hotel[0].number.must_equal 1
       ada_inn.hotel[-1].number.must_equal 20
       ada_inn.hotel[300].must_be_nil
     end

     it "Creates a list of reservations that is empty" do
       ada_inn.all_reservations.must_be_kind_of Array
       ada_inn.all_reservations.must_equal []
     end

   end #"initialize"

   describe "reserve" do
     before do
       @res1 = ada_inn.reserve(Date.new(2017,10,12), 3)
       @res2 = ada_inn.reserve(Date.new(2017,6,12), 7)

     end # before

     it "Creates a reservation object" do
       @res1.must_be_instance_of ReservationSystem::Reservation
     end # "returns a reservation object"

     it "Stores the reservation in a list of all reservations" do
       ada_inn.all_reservations.must_be_kind_of Array
       ada_inn.all_reservations.must_include @res1 && @res2
       #TODO check when there are multiple reservations, what new_reservation is
     end # "creates a reservation"

   end # "reserve"

   describe "search_reservations_by_date" do
     xit "Can list reservations including a specific date" do
       list = ada_inn.search_reservations_by_date(Date.new(2017,06,13))

       list.must_be_kind_of Array
       list
     end #" Can list reservations including a specific date"

   end # "search_reservations_by_date"

end #"Hotel"
