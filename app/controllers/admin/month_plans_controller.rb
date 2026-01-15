
module Admin
  class MonthPlansController < ApplicationController
    before_action :require_admin!
    before_action :set_month_plan, only: [:show, :edit, :update, :destroy]

    def index
      @month_plans = MonthPlan.order(start_date: :desc)
    end

    def show; end


    def duplicate
      source = MonthPlan.find(params[:id])
      new_start = (source.end_date + 1.day).beginning_of_month
      new_end   = new_start.end_of_month
      @month_plan = MonthPlan.new(title: new_start.strftime("%B %Y"), start_date: new_start, end_date: new_end)
      source.plan_exercises.each do |pe|
        @month_plan.plan_exercises.build(exercise_id: pe.exercise_id, target_sets: pe.target_sets, target_reps: pe.target_reps, target_weight: pe.target_weight)
      end
      render :new
    end


    def new
      @month_plan = MonthPlan.new(
        start_date: Date.current.beginning_of_month,
        end_date: Date.current.end_of_month
      )
      # Build a few nested rows initially
      3.times { @month_plan.plan_exercises.build }
    end

    def create
      @month_plan = MonthPlan.new(month_plan_params)
      if @month_plan.save
        redirect_to admin_month_plan_path(@month_plan), notice: "Month plan created"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      # Ensure at least one row present
      @month_plan.plan_exercises.build if @month_plan.plan_exercises.empty?
    end

    def update
      if @month_plan.update(month_plan_params)
        redirect_to admin_month_plan_path(@month_plan), notice: "Month plan updated"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @month_plan.destroy
      redirect_to admin_month_plans_path, notice: "Month plan deleted"
    end

    private
    def set_month_plan
      @month_plan = MonthPlan.find(params[:id])
    end

    def month_plan_params
      params.require(:month_plan).permit(
        :title, :start_date, :end_date,
        plan_exercises_attributes: [:id, :exercise_id, :target_sets, :target_reps, :target_weight, :_destroy]
      )
    end
  end
end
