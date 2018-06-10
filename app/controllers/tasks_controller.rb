class TasksController < ApplicationController
    def index
        @user = User.find(params[:user_id])
    end

    def add_selected
        task_id = params[:task_id]
        User.find(params[:user_id]).tasks << Task.all[task_id.to_i - 1]
        user = User.find(params[:user_id])
        respond_to do |format|
            format.html { redirect_to user_path(@user) }
            format.js { render :index, :locals => {:user_id => params[:user_id], :task_id => params[:task_id]} }
        end
        # redirect_to user_path(@user)
    end

    def remove_selected
        task_id = params[:task_id]
        User.find(params[:user_id]).tasks.destroy(task_id.to_i)
        @user = User.find(params[:user_id])

        respond_to do |format|
            format.html { redirect_to user_path(@user) }
            format.js { render :index, :locals => {:user_id => params[:user_id], :task_id => params[:task_id]} }
        end
        # redirect_to user_path(@user)
    end

end
