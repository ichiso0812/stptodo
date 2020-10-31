module Api
  module V1
    class TodoListsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_todo_list, only: [:show, :update, :destroy]

      # GET /todo_lists
      def index
        @todo_lists = current_user.todo_lists.all

        render json: @todo_lists
      end

      # GET /todo_lists/1
      def show
        render json: @todo_list
      end

      # POST /todo_lists
      def create
        @todo_list = TodoList.new(todo_list_params)

        if @todo_list.save
          render json: @todo_list, status: :created, location: @todo_list
        else
          render json: @todo_list.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /todo_lists/1
      def update
        if @todo_list.update(todo_list_params)
          render json: @todo_list
        else
          render json: @todo_list.errors, status: :unprocessable_entity
        end
      end

      # DELETE /todo_lists/1
      def destroy
        @todo_list.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_todo_list
          @todo_list = TodoList.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def todo_list_params
          params.require(:todo_list).permit(:title, :description, :project_id, :user_id)
        end
    end
  end
end
