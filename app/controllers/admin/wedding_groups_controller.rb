# app/controllers/admin/wedding_groups_controller.rb
class Admin::WeddingGroupsController < ApplicationController
  before_action :set_wedding_group, only: [:edit, :update, :show, :destroy]

  def index
    @wedding_groups = WeddingGroup.all
  end

  def new
    @wedding_group = WeddingGroup.new
  end

  def create
    @wedding_group = WeddingGroup.new(wedding_group_params)
    required_fields = %i[name wedding_date location]
    required_fields.each do |field|
      if @wedding_group.send(field).blank?
        @wedding_group.errors.add(field, "can't be blank")
      end
    end

    if @wedding_group.errors.any?
      render :new, status: :unprocessable_entity
    elsif @wedding_group.save
      redirect_to admin_wedding_groups_path, notice: "Wedding group created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    required_fields = %i[name wedding_date location]
    required_fields.each do |field|
      if params[:wedding_group][field].blank?
        @wedding_group.errors.add(field, "can't be blank")
      end
    end

    if @wedding_group.errors.any?
      render :edit, status: :unprocessable_entity
    elsif @wedding_group.update(wedding_group_params)
      redirect_to admin_wedding_groups_path, notice: "Wedding group updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @wedding_group.destroy
    redirect_to admin_wedding_groups_path, notice: "Wedding group deleted."
  end

  def add_member
    @wedding_group = WeddingGroup.find(params[:id])
    all_users = User.where.not(role: 'super_admin').order(:last_name)
    member_ids = @wedding_group.memberships.pluck(:user_id)
    @group_members = all_users.where(id: member_ids)
    @non_members = all_users.where.not(id: member_ids)
  end

  # POST /admin/wedding_groups/:id/add_member
  def set_member
    @wedding_group = WeddingGroup.find(params[:id])
    user = User.find(params[:user_id])
    @wedding_group.memberships.create(user: user, status: "approved")
    redirect_to add_member_admin_wedding_group_path(@wedding_group), notice: "Membership added."
  end

  # POST /admin/wedding_groups/:id/remove_member
  def remove_member
    @wedding_group = WeddingGroup.find(params[:id])
    membership = @wedding_group.memberships.find_by(user_id: params[:user_id])
    membership&.destroy
    redirect_to add_member_admin_wedding_group_path(@wedding_group), notice: "Membership removed."
  end

  def create_member
    @wedding_group = WeddingGroup.find(params[:id])
    @membership = @wedding_group.memberships.build(user_id: params[:user_id], status: "approved", role: "member")
    if @membership.save
      redirect_to admin_wedding_group_path(@wedding_group), notice: "Membership added and approved."
    else
      render :add_member
    end
  end

  def update_members
    @wedding_group = WeddingGroup.find(params[:id])
    @wedding_group.user_ids = params[:wedding_group][:user_ids].reject(&:blank?)
    @wedding_group.memberships.where(user_id: @wedding_group.user_ids).update_all(status: "approved")
    redirect_to add_member_admin_wedding_group_path(@wedding_group), notice: "Members updated."
  end

  def toggle_admin
    @wedding_group = WeddingGroup.find(params[:id])
    membership = @wedding_group.memberships.find_by(user_id: params[:user_id])
    if membership
      membership.update(is_group_admin: !membership.is_group_admin)
    end
    redirect_to add_member_admin_wedding_group_path(@wedding_group)
  end

  private

  def set_wedding_group
    @wedding_group = WeddingGroup.find(params[:id])
  end

  def wedding_group_params
    params.require(:wedding_group).permit(:name, :wedding_date, :location)
  end
end