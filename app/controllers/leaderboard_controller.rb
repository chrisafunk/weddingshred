
# app/controllers/leaderboard_controller.rb
class LeaderboardController < ApplicationController
  def index
    # Pick the current month plan or most recent fallback
    @month_plan = MonthPlan.current.first || MonthPlan.order(start_date: :desc).first

    unless @month_plan
      @rows = []
      return
    end

    # All entries in the month for quick filtering
    month_entries = WorkoutEntry.where(month_plan_id: @month_plan.id)

    # Days logged per user: count distinct dates with any entry
    # => returns { user_id => count }
    days_per_user = month_entries.group(:user_id).distinct.count(:performed_on)

    # Preload users to avoid N+1
    user_ids = days_per_user.keys
    users = User.where(id: user_ids).index_by(&:id)

    # Preload per-user dates to compute streaks
    dates_by_user = month_entries
                      .where(user_id: user_ids)
                      .distinct
                      .pluck(:user_id, :performed_on)
                      .group_by { |uid, _| uid }
                      .transform_values { |tuples| tuples.map { |(_, d)| d }.sort }

    today = Date.current

    @rows = days_per_user.map do |uid, days_count|
      streak = compute_current_streak(dates_by_user[uid] || [], today)
      {
        user: users[uid],
        days_logged: days_count,
        current_streak: streak,
        last_logged_on: (dates_by_user[uid] || []).max
      }
    end

    # Sort primarily by days_logged desc, then by current_streak desc, then last_logged_on desc
    @rows.sort_by! { |r| [ -r[:days_logged], -r[:current_streak], (r[:last_logged_on] || Date.new(0)) ] }
  end

  private

  # Walk backwards from today; count how many consecutive dates are present.
  def compute_current_streak(sorted_dates, today)
    return 0 if sorted_dates.empty?

    dates_set = sorted_dates.to_set # O(1) membership check
    streak = 0
    cursor = today

    while dates_set.include?(cursor)
      streak += 1
      cursor -= 1
    end

    streak
  end
end
