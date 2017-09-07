require_relative 'spec_helper.rb'

describe 'DateRange class' do
  describe 'initialize' do
    before do
      @day1 = Date.new(2017,8,3)
      @day2 = Date.new(2017,8,6)
    end

    it "Responds to checkin checkout" do
      newdate = Hotel::DateRange.new(@day1 ,@day2)
      newdate.checkin.must_equal @day1
      newdate.checkout.must_equal @day2
    end

    it "Can be initialize if the dates are right" do
      Hotel::DateRange.new( @day1, @day2).must_be_instance_of Hotel::DateRange
    end

    it "Raises error if checkout is before checkin" do
      proc {Hotel::DateRange.new(@day2, @day1)}.must_raise ArgumentError
    end

    it "Raises an error if checkin and checkout are equal" do
      proc{Hotel::DateRange.new(@day1, @day1)}.must_raise ArgumentError
    end

  end#describe initialize


  describe "stay_length" do
    before do
      @day1 = Date.new(2017,8,3)
      @day2 = Date.new(2017,8,4)
    end
    it "Should give the right amount of days" do
      newdate = Hotel::DateRange.new(@day1, @day2)
      newdate.stay_length.must_equal 1
    end
  end


end#big descrbe
