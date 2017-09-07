require_relative 'spec_helper'

describe 'Block Class' do
  it 'will initialize' do
    block = Hotel::Block.new('Diane', Date.new(2018,9,26), 120, [:room5, :room7, :room8])
    block.must_be_instance_of Hotel::Block
    
    block.must_respond_to :partyname
    block.must_respond_to :daterange
  end


end
