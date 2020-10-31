module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_project, only: [:show, :update, :destroy]

      # GET /projects
      def index
        @projects = current_user.projects.all

        render json: @projects
      end

      # GET /projects/1
      def show
        render json: @project
      end

      # POST /projects
      def create
        @project = Project.new(project_params)

        if @project.save
          render json: @project, status: :created, location: @project
        else
          render json: @project.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /projects/1
      def update
        if @project.update(project_params)
          render json: @project
        else
          render json: @project.errors, status: :unprocessable_entity
        end
      end

      # DELETE /projects/1
      def destroy
        @project.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_project
          @project = Project.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def project_params
          params.require(:project).permit(:name, :user_id)
        end
    end
  end
end