require_relative 'spec_helper.rb'

describe "hotel" do
  before do

  end
  it "has a hotel class" do
    Hotel::Room.class.must_be_kind_of Class
  end
end
