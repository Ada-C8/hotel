require_relative '../lib/blocks'
require_relative '../lib/reservation'
require_relative 'spec_helper'

describe "block" do

  it "can initialize a block" do
    block_1 = Hotel::Block.new( [2019, 11, 15], [2019, 11, 15], "T Payne", "8675309", 10)
    block_1.must_be_instance_of Hotel::Block
  end

  it "can return the correct information" do

    block_1 = Hotel::Block.new( [1900, 02, 20], [1900, 02, 22], "Dr. Frankenstein", "8675309", 15 )
    block_1.check_in.must_be_instance_of Date
    block_1.check_out.must_be_instance_of Date
    block_1.date_range.must_be_instance_of Array
    block_1.date_range.length.must_equal 2
    block_1.room.must_equal "TBD"
    block_1.name.must_equal "Dr. Frankenstein"
    block_1.contact_info.must_equal "8675309"
    block_1.price.must_equal 340
    block_1.discount.must_equal 0.85
    block_1.discount.must_be_instance_of Float
  end
end

describe "nights_reserved method" do
  it "can get dates from block" do
    block_1 = Hotel::Block.new([2019, 11, 15], [2019, 11, 17], "Dr. Frankenstein", "8675309", 20 )
    range_dates = block_1.dates_reserved
    range_dates[0].must_equal Date.new(2019, 11, 15)
  end
end
describe "change_discount" do
  it "can change the discount on a block" do
    block_1 = Hotel::Block.new( [1900, 02, 20], [1900, 02, 22], "Dr. Frankenstein", "8675309", 15 )
    block_1.change_discount(70)
    block_1.discount.must_equal 0.30
  end
end
