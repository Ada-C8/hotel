# require_relative 'spec_helper.rb'
#
# describe 'BlockAdmin' do
#   before do
#     @adminblock = Hotel::BlockAdmin.new
#     @admin = Hotel::Admin.new
#   end
#   # describe 'initialize' do
#   #   it 'can be initialize' do
#   #     Hotel::BlockAdmin.new.must_be_instance_of Hotel::BlockAdmin
#   #   end
#   # end
#
#   describe 'can create block?' do
#     before do
#       @checkin = Date.new(2017,11,5)
#       @checkout = Date.new(2017,11,9)
#     end
#     it 'raises an error if there is the number of rooms to reserve is bigger than 5'  do
#       proc{@adminblock.can_create_block?(@checkin, @checkout, 7)}.must_raise ArgumentError
#     end
#
#     it 'returns true if it is possible to create the block' do
#       @adminblock.can_create_block?(@checkin, @checkout, 4).must_equal true
#     end
#   end
# end
