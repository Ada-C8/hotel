require_relative 'spec_helper.rb'

describe "Hotel_System::Reservations" do

it "can initialize a new reservation" do
reservation = Hotel_System::Reservations.new(1, "1-1-2018", "1-5-2018")
reservation.must_be_instance_of Hotel_System::Reservations
end

it "accepts an appropriate check in date" do
reservation = Hotel_System::Reservations.new(1, "1-1-2018", "1-5-2018")
reservation.check_in.must_be_instance_of Date
reservation.check_out.must_be_instance_of Date
reservation.check_in.strftime("%Y-%m-%d").must_equal("2018-01-01")
reservation.check_out.strftime("%Y-%m-%d").must_equal("2018-05-01")
end

it "checks that the check in date is not in the past" do


end

it "checks the check out date is not in the past" do

end

it "checks the check out date is after the check in date" do

end

it "checks the check in date is not the same as the check out date" do

end

end
