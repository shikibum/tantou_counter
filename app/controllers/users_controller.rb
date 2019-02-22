# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @tantous = User.find_by(share_id: params[:id])&.tantous.where.not(katana_id: nil).order(created_at: :desc)
  end
end
