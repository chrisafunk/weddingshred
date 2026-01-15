
module Admin
  class ExercisesController < ApplicationController
    before_action :require_admin!
    before_action :set_exercise, only: [:edit, :update, :destroy]

    def index
      @exercises = Exercise.order(:name)
    end

    def new
      @exercise = Exercise.new
    end

    def create
      @exercise = Exercise.new(exercise_params)
      if @exercise.save
        redirect_to admin_exercises_path, notice: "Exercise created"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @exercise.update(exercise_params)
        redirect_to admin_exercises_path, notice: "Exercise updated"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @exercise.destroy
      redirect_to admin_exercises_path, notice: "Exercise deleted"
    end

    private
    def set_exercise
      @exercise = Exercise.find(params[:id])
    end

    def exercise_params
      params.require(:exercise).permit(:name, :category, :unit)
    end
  end
end
