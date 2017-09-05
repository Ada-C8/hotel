require_relative 'date_range'

describe "#initialize" do
  it "Check_in value can be called by .check_in" do
    new_date_range = BookingSystem::DateRange.new("09-15-2017", "09-17-2017")
    new_date_range.check_in.must_equal "2017-09-15"
    new_date_range.check_out.must_equal "2017-09-17"
  end

  xdescribe "" do
    it "Returns true if given date range is valid" do
      date_range = BookingSystem::DateRange.new("09-15-2017", "09-17-2017")

    end
  end




end #end of discribe
