require_relative 'spec_helper'

describe 'Block' do

  describe 'initialize' do
    it "must be an instance of a Block" do
      new_block = block.new
      new_block.must_be_instance of Hotel::Block
    end
  end




end
