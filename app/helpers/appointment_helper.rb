module AppointmentHelper
  def appdays(user)
    dates = []
    @companions.each do | companion|
      dates.push(companion.start_date)
    end
    dates
  end

  def sendays(user)
    dates = []
    @seniors.each do | senior|
      if senior.accept === true
        dates.push(senior.start_date)
      end
    end
    dates
  end
end
