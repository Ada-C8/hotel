module Hotel

  def self.confirm_yes_no
    confirm = gets.chomp.upcase
    legal_answers = ["Y", "N", "YES", "NO"]

    until legal_answers.include? confirm
      puts "Please answer YES or NO."
      confirm = gets.chomp.upcase
    end
    return confirm
  end


end
