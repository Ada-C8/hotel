require_relative 'spec_helper'

describe "Command Line Interface" do
  before do
    @interface = Hotel::Cli.new
  end

  it " can create an instance" do
    @interface.must_be_instance_of Hotel::Cli
  end

  it "initializes with a hotel" do
    @interface.hotel.must_be_instance_of Hotel::Hotel
  end

  it "displays_user_menu" do
    @interface.must_respond_to :display_user_menu
  end







end
