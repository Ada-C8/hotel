#block_spec.rb

require_relative 'spec_helper.rb'
require 'date'
require 'pry'

describe "The Block class" do

  before do
    @hotel = Hotel_Chain::Hotel.new
  end

  describe "Initializing the Block" do

    it "can be initialized" do
      block_A = Hotel_Chain::Block.new("Mary Smith", "9/25/17", "9/29/17", 150, [])
      block_A.class.must_be_kind_of Class
    end

  end #end describe
end #final end
