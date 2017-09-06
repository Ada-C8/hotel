require_relative '../lib/admin'
require_relative 'spec_helper'

describe "class Admin" do
  it "instantiates all hotel rooms" do
    admin_1 = Hotel::Admin.new
  end
end
