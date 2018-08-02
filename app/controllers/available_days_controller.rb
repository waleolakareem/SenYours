class AvailableDaysController < ApplicationController
  def index
  end

  def add_available_day
    # {"available_day"=>{"comment"=>"I am ready", "date"=>"2018-08-11", "user_id"=>"1"}}
    # Sets date as available for Appointments
    @user = current_user
    @available_day = AvailableDay.create(available_days_params)
    puts '@!@!@!@!@ response_to'
    respond_to do |format|
      format.js { render 'calender' }
      format.html {redirect_to user_path(current_user)}
    end
  end

  def remove_available_day
    # Sets date as available for Appointments
    @user = current_user
    @availableDay = AvailableDay.where({ user_id: current_user.id, date: params[:available_day][:date] })
    puts "Record: #{@availableDay}"
    AvailableDay.destroy(@availableDay[0].id)
    puts '@!@!@!@!@ response_to'
    respond_to do |format|
      format.js { render 'calender' }
      format.html {redirect_to user_path(current_user)}
    end
  end

  def new
    @user = current_user
    @available_day = AvailableDay.new
    @current_date = current_user.available_days
    @availableDay = @current_date.where('user_id = current_user','date=date')
  end

  def create
    @availableDay = AvailableDay.where('date = ? AND user_id = ?', available_days_params[:date], available_days_params[:user_id])
    if @availableDay.length >= 1
      @deldate = @availableDay[0]
      @availableDay[0].destroy
      respond_to do |format|
        format.html {redirect_to new_user_available_day_path(@user)}
        format.js {render 'new_del'}
      end
    elsif @availableDay.length <= 1
      @availableDay = AvailableDay.create(available_days_params)
      respond_to do |format|
        format.html {redirect_to new_user_available_day_path(@user)}
        format.js {render 'new'}
      end
    else
      redirect_to "new"
    end
  end

  def edit

  end

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

  def destroy
    @availableDay = AvailableDay.where({user_id:current_user,date: params[:id]})
    @availableDay[0].destroy
    redirect_to new_user_available_day_path(current_user)
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  private
  def available_days_params
    params.require(:available_day).permit(:user_id, :comment, :date)
  end
end
