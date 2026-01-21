class GroupAdminMembershipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @wedding_group = WeddingGroup.find(params[:wedding_group_id])
    @memberships = @wedding_group.memberships.includes(:user)
                                 .reject { |m| m.user.role == "super_admin" }
  end

  def join
    membership = Membership.find(params[:id])
    membership.update(status: "active")
    redirect_to group_admin_memberships_path(wedding_group_id: membership.wedding_group_id), notice: "You have joined the group."
  end

  def unjoin
    membership = Membership.find(params[:id])
    membership.update(status: "pending")
    redirect_to group_admin_memberships_path(wedding_group_id: membership.wedding_group_id), notice: "Membership set to pending."
  end

  def update_role
    membership = Membership.find(params[:id])
    membership.user.update(role: params[:role])
    redirect_to group_admin_memberships_path(wedding_group_id: membership.wedding_group_id), notice: "Role updated."
  end


end