
# app/services/leaderboard_query.rb
class LeaderboardQuery
  # Public API:
  #   for_month(month_plan_id:)
  #   all_time
  #
  # Returns array of rows:
  #   [{ user:, days_logged:, current_streak:, last_logged_on: }, ...]

  def self.for_month(month_plan_id)
    return [] if month_plan_id.blank?

    scope = WorkoutEntry.where(month_plan_id: month_plan_id)
    days_per_user = scope.group(:user_id).distinct.count(:performed_on)

    user_ids = days_per_user.keys
    users = User.where(id: user_ids).index_by(&:id)

    # Collect distinct dates per user to compute streaks
    dates_by_user = scope
                      .where(user_id: user_ids)
                      .distinct
                      .pluck(:user_id, :performed_on)
                      .group_by { |uid, _| uid }
                      .transform_values { |tuples| tuples.map { |(_, d)| d }.sort }

    today = Date.current

    rows = days_per_user.map do |uid, count|
      streak = compute_current_streak(dates_by_user[uid] || [], today)
      {
        user: users[uid],
        days_logged: count,
        current_streak: streak,
        last_logged_on: (dates_by_user[uid] || []).max
      }
    end

    sort_rows!(rows)
  end

  def self.all_time
    scope = WorkoutEntry.all
    days_per_user = scope.group(:user_id).distinct.count(:performed_on)
    user_ids = days_per_user.keys
    users = User.where(id: user_ids).index_by(&:id)

    dates_by_user = scope
                      .where(user_id: user_ids)
                      .distinct
                      .pluck(:user_id, :performed_on)
                      .group_by { |uid, _| uid }
                      .transform_values { |tuples| tuples.map { |(_, d)| d }.sort }

    today = Date.current

    rows = days_per_user.map do |uid, count|
      streak = compute_current_streak(dates_by_user[uid] || [], today)
      {
        user: users[uid],
        days_logged: count,              # over all time
        current_streak: streak,          # streak up to today (all-time)
        last_logged_on: (dates_by_user[uid] || []).max
      }
    end

    sort_rows!(rows)
  end

  # ---------- helpers ----------
  def self.compute_current_streak(sorted_dates, today)
    return 0 if sorted_dates.empty?
    dates_set = sorted_dates.to_set
    streak = 0
    cursor = today
    while dates_set.include?(cursor)
      streak += 1
      cursor -= 1
    end
    streak
  end

  def self.sort_rows!(rows)
    rows.sort_by! { |r| [ -r[:days_logged], -r[:current_streak], (r[:last_logged_on] || Date.new(0)) ] }
    rows
  end
end
