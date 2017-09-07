require_relative 'spec_helper'

describe "Block" do
  before do
    @rooms = [1, 2, 3]
    @check_in = Date.new(2017,9,15)
    @check_out = Date.new(2017,9,17)
    @date_range = BookingSystem::DateRange.new(@check_in, @check_out)
    @new_block = BookingSystem::Block.new(@date_range, @rooms)
  end
  describe "#initialize" do
    it "ID should be an integer" do
      @new_block.id.must_be_kind_of Integer
    end
    it "Date_range can be called by .date_range" do
      @new_block.date_range.must_equal @date_range
    end
    it "Total cost should be an integer" do
      @new_block.room_cost.must_be_kind_of Integer
    end
    it "Returns the rigth total cost" do
      @new_block.room_cost.must_equal 180
    end
  end

  describe "#has_available_rooms?" do
    before do
      @hotel = BookingSystem::Hotel.new(5)
      @new_block = @hotel.create_block(@date_range, 3)
    end
    it "Returns true if there are available rooms in given block" do
      @new_block.has_available_rooms?.must_equal true
    end
    it "Returns false if there is no available rooms in given block" do
      3.times do
        @hotel.make_reservation_from_block(@new_block)
      end
      @new_block.has_available_rooms?.must_equal false
    end
  end

end #end of describe
