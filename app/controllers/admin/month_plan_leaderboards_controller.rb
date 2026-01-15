
# app/controllers/admin/month_plan_leaderboards_controller.rb
module Admin
  class MonthPlanLeaderboardsController < ApplicationController
    before_action :require_admin!

    def show
      @month_plan = MonthPlan.find(params[:id])
      # Reuse the same logic from LeaderboardController#index (extract into a service if you prefer)
    end
  end
end
