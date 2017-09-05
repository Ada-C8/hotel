require_relative 'spec_helper.rb'

describe "Hotel_System::Reservations" do

it "can initialize a new reservation" do
# hotel = Hotel_System::Hotel.new(20)
reservation = Hotel_System::Reservations.new(1, "1-1-2018", "1-5-2018")
reservation.must_be_instance_of Hotel_System::Reservations

end



end
