module AvailableDaysHelper
  def aval(user1, user2)
    user1_dates = []
    user1.available_days.each do |day|
      user1_dates.push(day.date)
    end

    user2_dates = []
    user2.available_days.each do |day|
      user2_dates.push(day.date)
    end

    date_match = user1_dates & user2_dates
  end
end
