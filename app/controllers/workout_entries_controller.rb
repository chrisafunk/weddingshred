
class WorkoutEntriesController < ApplicationController
  before_action :set_entry, only: [:edit, :update, :destroy]

  def index
    @month_plan = MonthPlan.current.first || MonthPlan.order(start_date: :desc).first
    @entries = current_user.workout_entries.includes(:exercise, :month_plan)
                           .where(month_plan: @month_plan)
                           .order(performed_on: :desc)
  end

  def new
    @month_plan = MonthPlan.find_by(id: params[:month_plan_id]) || MonthPlan.current.first
    @workout_entry = current_user.workout_entries.build(month_plan: @month_plan, performed_on: Date.current)
    @exercises = @month_plan ? @month_plan.exercises.order(:name) : Exercise.none
  end

  def create
    @workout_entry = current_user.workout_entries.build(entry_params)
    if @workout_entry.save
      redirect_to workout_entries_path, notice: "Workout logged"
    else
      @month_plan = @workout_entry.month_plan
      @exercises = @month_plan ? @month_plan.exercises.order(:name) : Exercise.none
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @month_plan = @workout_entry.month_plan
    @exercises = @month_plan.exercises.order(:name)
  end

  def update
    if @workout_entry.update(entry_params)
      redirect_to workout_entries_path, notice: "Entry updated"
    else
      @month_plan = @workout_entry.month_plan
      @exercises = @month_plan.exercises.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @workout_entry.destroy
    redirect_to workout_entries_path, notice: "Entry deleted"
  end

  private
  def set_entry
    @workout_entry = current_user.workout_entries.find(params[:id])
  end

  def entry_params
    params.require(:workout_entry).permit(
      :month_plan_id, :exercise_id, :performed_on,
      :sets, :reps, :weight, :duration_minutes, :distance_km, :notes
    )
  end
end
