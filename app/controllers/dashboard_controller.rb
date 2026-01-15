
class DashboardController < ApplicationController
  def index
    @month_plan = MonthPlan.current.first
    @today_entries = current_user.workout_entries.where(performed_on: Date.current)
                                 .includes(:exercise).order("exercises.name")
  end
end
