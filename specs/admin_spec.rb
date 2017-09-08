require_relative '../lib/admin'
require_relative 'spec_helper'
require 'pry'

describe "class Admin" do

  describe "initialize" do
    it "initializes all instance variables" do
      admin_1 = Hotel::Admin.new
      admin_1.all_rooms.length.must_equal 20
      admin_1.reservations_list.must_be_instance_of Array
      admin_1.must_be_instance_of Hotel::Admin
      admin_1.block_list.must_be_instance_of Hash
    end
  end


end#end describe Admin
