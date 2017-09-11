require_relative 'spec_helper'

describe "Command Line Interface" do
  describe "creating and beginning" do
    before do
      @interface = Hotel::Cli.new
    end

    it "can create an instance" do
      @interface.must_be_instance_of Hotel::Cli
    end

    it "initializes with a hotel" do
      @interface.hotel.must_be_instance_of Hotel::Hotel
    end
  end

  describe "display_user_menu" do
    it "displays the user menu" do
      interface = Hotel::Cli.new
      interface.must_respond_to :display_user_menu
    end
  end

  describe "get menu option" do
    it "accepts A as a user option" do
      class Hotel::Cli
        def get_input
          return "A"
        end
      end

      interface = Hotel::Cli.new
      interface.get_menu_option.must_equal "A"
    end
    it "accepts i as a user option and returns I" do
      class Hotel::Cli
        def get_input
          return "i"
        end
      end

      interface = Hotel::Cli.new
      interface.get_menu_option.must_equal "I"
    end
    it "accepts x as a user option and returns X" do
      class Hotel::Cli
        def get_input
          return "x"
        end
      end

      interface = Hotel::Cli.new
      interface.get_menu_option.must_equal "X"
    end
  end


  describe "reserve room" do
  before do
    # @interface = Hotel::Cli.new
    # class Hotel::Cli
    #   def get_date_for
    #     Date.new(2018, 5, 5)
    #   end
    #   def check_out
    #     Date.new(2018, 5, 8)
    #   end
    #   def room
    #     return 18
    #   end
    #   def get_input
    #     return "Shaunna"
    #   end
    # end
  end
    it "increases the reservation by one" do
      # before = @interface.hotel.reservations.clone.length
      #
      # @interface.reserve_room
      #
      # after = @interface.hotel.reservations.length
      #
      # (before + 1).must_equal after


    end
  end





  # Doesn't properly test for content of table or that table shows up in the terminal
  describe "show_tables" do
    before do
      @interface = Hotel::Cli.new

        check_in = Date.new(2018, 7, 6)
        check_out = Date.new(2018, 7, 8)

      (1..10).each do |num|
        @interface.hotel.make_reservation("guest", check_in, check_out, num)
      end
    end

    it "returns the table of rooms" do
      table = @interface.show_table_of_rooms(@interface.hotel.rooms)
      table.rows.length.must_equal 21
    end

    it "returns the table of reservations" do
      table = @interface.show_table_of_reservations(@interface.hotel.reservations)
      table.rows.length.must_equal 11
    end
  end

end
