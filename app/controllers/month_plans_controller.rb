
# app/controllers/month_plans_controller.rb
class MonthPlansController < ApplicationController
  def exercises
    mp = MonthPlan.find(params[:id])
    render json: mp.exercises.order(:name).select(:id, :name)
  end
end
