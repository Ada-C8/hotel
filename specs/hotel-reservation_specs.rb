require_relative 'spec_helper.rb'

describe "Hotel::Reservation" do
  describe "Reservation instantiation" do
    before do
      @start_date = Date.new(2017,9,5)
      @end_date = Date.new(2017,9,8)
    end
    it "can be initialized" do
      Hotel::Reservation.new(@start_date,@end_date,1).must_be_instance_of Hotel::Reservation
    end

    it "" do

    end

  end
end
