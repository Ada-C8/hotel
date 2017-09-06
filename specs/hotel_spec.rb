=begin
#this doesn't run. I think I need to navigate to the hotel directory on
the Desktop and do the following commands:

sudo gem install minitest-reporter
sudo gem install simplecov
=end
require_relative 'spec_helper'

describe "initialize" do
  it "checks initialize" do
    a = hotel.new()
    a.delete_me_i_am_test.is_kind_of Array
  end
end
