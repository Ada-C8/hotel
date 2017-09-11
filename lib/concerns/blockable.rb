module Hotel
  module Blockable
    module InstanceMethods
      include Hotel::Dateable::InstanceMethods

      def create_block(check_in, check_out, name, contact_info, discount, num_rooms)

        available_rooms = rooms_available?(check_in, check_out)
        num_rooms_in_range?(num_rooms, available_rooms)
        #id_num = SecureRandom.uuid don't need it, but I like the idea

        @block_list << Hotel::Block.new(check_in, check_out, name, contact_info, discount, num_rooms)

      end


      def convert_block_to_reservation(name)
        being_converted = finder(name, :name, block_list)
        @block_list = @block_list - being_converted
        being_converted.each{ |block|  block.num_rooms.times do |thing|
          reserve(block.check_in, block.check_out, rooms_available?(block.check_in, block.check_out)[0], block.name, block.contact_info)
        end
      }
      @block_list = @block_list - being_converted
    end

    def delete_block(name)
      being_deleted = finder(name, :name, block_list)
      # binding.pry
      @block_list = @block_list - being_deleted
    end

    def find_block_name(name)
      finder(name, :name, block_list)
    end

    def find_block_by_date(date)
      finder(date, :date_range, block_list)

    end

    def number_rooms_blocked_by_date_range(check_in, check_out)
      num_rooms = 0
      date_range = get_date_range(check_in, check_out)
      date_range.each do |date|
        blocks_dates =  @block_list.find_all{|block| (block.date_range & date_range).any?}
        num_rooms = blocks_dates.sum{|block| block.num_rooms}
      end
      num_rooms
    end

    private
    def num_rooms_in_range?(num, rooms_available)

      raise ArgumentError.new("The number of rooms is out of range") if num > rooms_available.length

    end


    end #blockable
  end #InstanceMethods
end #Hotel
