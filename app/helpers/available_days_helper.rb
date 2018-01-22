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

  def aval_time(user1,user2,date)
    x = []
    y = []
    time_one = []
    time_two = []
      x = user1.available_days.where(date: date)
      y = user2.available_days.where(date: date)
    if x.length != 0 && y.length != 0
       x[0].available_times.each do |time|
        time_one.push(time.time)
      end
       y[0].available_times.each do |time|
        time_two.push(time.time)
      end
    end
    final_time = time_one & time_two
  end

  def date_exit(user)
    dates = []
    user.available_days.each do |day|
      dates.push(day.date)
    end

    dates
  end
end
