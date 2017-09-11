require 'date'

module HotelBooking

  class Room
    attr_reader :id, :nightly_rate, :type, :reserv_ids, :all_dates, :block_ids, :blocks_available

    def initialize(id_number, nightly_rate = 200)
      @id = id_number
      @nightly_rate =  nightly_rate
      @type = :standard
      @reserv_ids = []
      @block_ids = []
      @all_dates = []
      @blocks_available = []
    end

    def reserve_room(check_in,check_out,reservation_id, guest_id=nil)

      (check_in...check_out).each do |date|
        @all_dates << date
      end

      @reserv_ids << reservation_id
    end

    def reserve_block_room(block_id, reservation_id, guest_id=nil)
      raise ArgumentError.new("This Block room is not available for this block reservation") if !(@blocks_available.include?(block_id))

      @blocks_available.delete(block_id)
    end


    def block_room(check_in,check_out,block_id)
      (check_in...check_out).each do |date|
        return false if @all_dates.include?(date)
      end

      @blocks_available << block_id

      (check_in...check_out).each do |date|
        @all_dates << date
      end
    end

    def available_all_days?(check_in, check_out)
      (check_in..check_out).each do |date|
        return false if @all_dates.include?(date)
      end

      return true
    end

  end

end
