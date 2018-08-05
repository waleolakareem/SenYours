class AvailableDaysController < ApplicationController
  def index
  end

# BEGIN Blaine's Update

  def set_date_unavailable
    # Set Date as Unavailable.
    @availableDay = AvailableDay.where({ user_id: current_user.id, date: params[:available_day][:date] })
    AvailableDay.destroy(@availableDay[0].id)
  end

  def set_date_available
    # Set Date as Available.
    @available_day = AvailableDay.create(available_days_params)
  end

  def time_sheet
    @availableDay = AvailableDay.where({user_id:current_user,date: available_days_params[:date]})
    @all_times = ["07:00AM","08:00AM","09:00AM","10:00AM","11:00AM","12:00PM","01:00PM","02:00PM","03:00PM","04:00PM","05:00PM","06:00PM","07:00PM"]
    # Opens specific dates Timesheet
  end

  def set_time_unavailable
    # Set Time as Unavailable.
  end

  def set_time_available
    # Set Time as Available.
  end

# END Blaine's Update

  def update
    @availableDay = AvailableDay.find(params[:id])
    @time = @availableDay.available_times.where('time = ? ', params[:time])
    if @time.length >= 1
      @show_del = @time[0].time.strftime('%I%p')
      @real_show_del = @time[0].time.strftime('%I:%M%p')
      @time[0].destroy
      respond_to do |format|
        format.html {redirect_to available_day_path(available_day:{date: @availableDay.date,user_id: current_user.id,comment: 'I am ready'},id: @availableDay.id)}
        format.js {render 'show_del'}
      end
    else
      @time = @availableDay.available_times.new(time: params[:time])
      if @time.save
        @real_time = @time.time.strftime('%I:%M%p')
        @time = @time.time.strftime('%I%p')
        respond_to do |format|
          format.html {redirect_to available_day_path(available_day:{date: @availableDay.date,user_id: current_user.id,comment: 'I am ready'},id: @availableDay.id)}
          format.js {render 'show'}
        end
      end
    end
  end

  def show
    @availableDay = AvailableDay.where({user_id:current_user,date: available_days_params[:date]})
    @arr = ["07:00AM","08:00AM","09:00AM","10:00AM","11:00AM","12:00PM","01:00PM","02:00PM","03:00PM","04:00PM","05:00PM","06:00PM","07:00PM"]
    @checkdate = @availableDay[0].try(:date)
    if(@availableDay.present?)
      @next_date =  AvailableDay.where({user_id:current_user}).where("date>?",@availableDay[0].date).order("date ASC").limit(1).first.try(:date)
      @prev_date =  AvailableDay.where({user_id:current_user}).where("date<?",@availableDay[0].date).order("date DESC").limit(1).first.try(:date)
    end
    @last_date = current_user.available_days.order('ASC')
    @first_date = current_user.available_days.order('ASC')
  end

  private
  def available_days_params
    params.require(:available_day).permit(:user_id, :comment, :date)
  end
end
