require_relative 'spec_helper'
require_relative '../lib/block'

describe 'Block' do

  before do
    @check_in = Date.new(2017, 5, 5)
    @check_out = @check_in + 3
    @price = 150
  end

  it "block is a subclass of Range"do
  @rooms = [5, 12, 15]
  @reserved_block = Property::Block.new(@rooms, @check_in, @check_out, @price)
  @reserved_block.must_be_kind_of Property::Range
  end

it "A block can contain a maximum of 5 rooms" do
  @rooms = [1, 2, 3, 4, 5, 6]
  proc {@reserved_block = Property::Block.new(@rooms, @check_in, @check_out, @price)}.must_raise ArgumentError
end

it "block should only include rooms that are available for the given date range" do
  @rooms = [1, 2, 3]
  @reserved_block = Property::Block.new(@rooms, @check_in, @check_out, @price)
end

it "a room is set aside in a block, it is not available for reservation by the general public, nor can it be included in another block" do

end

# it "can reserve a room from within a block of rooms" do
#
# end
#
#
# it "When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block" do
#
# end
end
