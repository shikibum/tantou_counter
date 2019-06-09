# frozen_string_literal: true

class CampaignsController < ApplicationController
  before_action :require_current_user

  def index
    @user = User.find_by(share_id: params[:user_id])
    @campaigns = @user.campaigns
  end

  def show
    @user = User.find_by(share_id: params[:user_id])
    @campaign = Campaign.find(params[:id])
    @stat = Stat.new(@user, @campaign)
    render 'users/show'
  end
end
