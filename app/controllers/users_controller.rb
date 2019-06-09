# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    user = User.find_by(share_id: params[:id])
    @campaign = Campaign.latest
    @stat = Stat.new(user, @campaign)
  end
end
