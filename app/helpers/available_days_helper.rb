module AvailableDaysHelper
  def aval(user1, user2)
    user1_dates = []
    user1.available_days.each do |day|
      if day.date >= Date.today
        user1_dates.push(day.date)
      end
    end

    user2_dates = []
    user2.available_days.each do |day|
      if day.date >= Date.today
        user2_dates.push(day.date)
      end
    end

    date_match = user1_dates & user2_dates
    date_match.sort
  end

  def aval_time(user1,user2,date)
    x = []
    y = []
    time_one = []
    time_two = []
      x = user1.available_days.where(date: date)
      y = user2.available_days.where(date: date)
      # Just concatenate instead of going through each
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

  def stripoff(available_day)
    convert = []
    available_day.available_times.each do |time|
      convert.push(time.time.strftime('%I:%M%p'))
    end
     convert
  end

  def app_time(user,available_day)
    app_date = user.companions.where("start_date = ?", available_day.date)
      if app_date.size >= 1
      app_work =  AvailableDay.where("date = ?",app_date[0].start_date)
      final = []
      app_work[1].available_times.each do |time|
        final.push(time.time.strftime('%I:%M%p'))
      end
       final
      end
  end
end
