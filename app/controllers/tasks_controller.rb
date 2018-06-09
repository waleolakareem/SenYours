class TasksController < ApplicationController
    def index
    end

    def select_task
      task_id = params[:task_id]
      User.find(params[:user_id]).tasks << Task.all[task_id.to_i - 1]
      @user = User.find(params[:user_id])
      redirect_to user_path(@user)
      respond_to do |format|
        format.js { render 'select_task.js.erb' }
      end
    end

    def unselect_task
      task_id = params[:task_id]
      User.find(params[:user_id]).tasks.destroy(task_id.to_i)
      @user = User.find(params[:user_id])
      redirect_to user_path(@user)
    end

end
