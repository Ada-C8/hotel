require_relative 'spec_helper'

describe "Admin" do
  before do
    @admin = Hotel::Admin.new()
  end

  describe "initialize" do
    it "Can initialize an object of class Admin" do
      @admin.must_be_instance_of Hotel::Admin
      @admin.rooms.must_be_instance_of Array
    end
  end



end
