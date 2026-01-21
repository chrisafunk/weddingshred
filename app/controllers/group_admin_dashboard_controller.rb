# app/controllers/group_admin_dashboard_controller.rb
class GroupAdminDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_group_admin

  def index
    if current_user.role == "super_admin"
      @wedding_groups = WeddingGroup.all
    elsif current_user.role == "group_admin"
      @wedding_groups = WeddingGroup.joins(:memberships)
                                    .where(memberships: { user_id: current_user.id, role: "group_admin" })
                                    .distinct
    else
      @wedding_groups = WeddingGroup.none
    end
    if @wedding_groups.size == 1
      @selected_group_id = @wedding_groups.first.id
    else
      @selected_group_id = params[:wedding_group_id] || session[:selected_group_id]
    end
    @selected_group = @wedding_groups.find { |g| g.id.to_s == @selected_group_id.to_s }

    session[:selected_group_id] = @selected_group_id if @selected_group_id

  end

  private

  def require_group_admin
    unless current_user&.role.in?(%w[group_admin super_admin])
      redirect_to root_path, alert: "Access denied."
    end
  end
end
