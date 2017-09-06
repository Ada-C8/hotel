require_relative "spec_helper"

describe "California class" do
  before do
    @california = Hotel::California.new
  end

  describe "initialize" do
    it "Creates an instance" do
      @california.must_be_kind_of Hotel::California
    end

    it "Can access rooms & reservations" do
      @california.rooms.must_be_instance_of Hash
      @california.rooms.length.must_equal 20
      @california.reservations.must_be_instance_of Array
    end
  end

end
