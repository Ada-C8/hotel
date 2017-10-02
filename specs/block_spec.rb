require_relative "spec_helper"

describe "Block class" do
  # using let()!
  let(:block) {Hotel::Block.new("2017-03-01", "2017-03-05")}

  describe "initialize" do
    it "Creates an instance" do
      block.must_be_kind_of Hotel::Block
    end

    it "Can access Reservation initialize" do
      block.start_date.must_equal "2017-03-01"
      block.end_date.must_equal "2017-03-05"
      block.dates.must_be_instance_of Array
    end
  end
end
