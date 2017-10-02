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

  describe 'include?' do
    before do
      @checkin = Date.new(2017,9,10)
      @checkout = Date.new(2017,9,13)
      @newdaterange = Hotel::DateRange.new(@checkin, @checkout)
    end

    it 'returns true, if the date is include' do
      date = Date.new(2017,9,11)
      @newdaterange.include?(date).must_equal true
    end

    it 'returns true if the date is the checkin date' do
      @newdaterange.include?(@checkin).must_equal true
    end

    it 'returns false for the checkout date' do
      @newdaterange.include?(@checkout).must_equal false
    end

    it 'returns false for a date out of range' do
      date = Date.new(2017,9,15)
      @newdaterange.include?(date).must_equal false
    end

  end

  describe 'overlap?' do
    before do
      @day1 = Date.new(2017,12, 13)
      @day2 = Date.new(2017,12, 19)
      @dr1 = Hotel::DateRange.new(@day1, @day2)
      @day3 = Date.new(2017,12,7)
      @day4 = Date.new(2017,12,12)
      @day5 = Date.new(2017,12,24)
      @day6 = Date.new(2017,12,14)
      @day7 = Date.new(2017,12,16)
      @dr2 = Hotel::DateRange.new(@day3,@day4)
      @dr3 = Hotel::DateRange.new(@day2,@day5)
      @dr4 = Hotel::DateRange.new(@day6,@day7)
      @dr5 = Hotel::DateRange.new(@day6,@day5)
      @dr6 = Hotel::DateRange.new(@day3,@day5)
      @dr7 = Hotel::DateRange.new(@day3,@day6)
    end

    it "returns false if the intervals are disconect" do
      @dr1.overlap?(@dr2).must_equal false
      @dr1.overlap?(@dr3).must_equal false
    end

    it "returns true if the dates ranges overlap" do
      @dr1.overlap?(@dr4).must_equal true
      @dr1.overlap?(@dr5).must_equal true
      @dr1.overlap?(@dr6).must_equal true
      @dr1.overlap?(@dr7).must_equal true
    end
  end#overlap

end#big describe
