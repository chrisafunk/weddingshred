
class DashboardController < ApplicationController
  def index
    @is_group_admin = current_user.memberships.any?(&:is_group_admin?)
    @admin_groups = current_user.memberships.select(&:is_group_admin?).map(&:wedding_group) if @is_group_admin
  end
end
