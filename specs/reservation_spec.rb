require_relative 'spec_helper.rb'

describe "reservation" do
  it "is a class" do
    Hotel::Reservation.class.must_be_kind_of Class
  end
end
