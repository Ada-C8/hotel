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

  it "block cannot be booked if no rooms available" do
    @rooms = []
    proc {@reserved_block = Property::Block.new(@rooms, @check_in, @check_out, @price)}.must_raise ArgumentError
  end

  it "block rooms must appear in reservations once booked" do
    @rooms = [5, 12, 15]
    @reserved_block = Property::Block.new(@rooms, @check_in, @check_out, @price)
    @reserved_block.rooms.each do |room|
    @reservations.must_include room
    end
  end
end
