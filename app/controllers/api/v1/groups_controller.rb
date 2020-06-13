class Api::V1::GroupsController < ApplicationController

  def index
    # @user = current_user

    success_response({})
  end

  def create
    @group = Group.new(group_params)
    return create_response({}) if @group.save

    bad_response(@group.errors)
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
