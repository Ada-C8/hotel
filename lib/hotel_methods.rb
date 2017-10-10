module Hotel

  def self.date_ify(date)
    return Date.strptime(date, '%m-%d-%Y')
  end
end
