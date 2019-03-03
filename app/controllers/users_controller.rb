# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    user = User.find_by(share_id: params[:id])
    @tantous = user&.tantous.where.not(katana_id: nil).order(created_at: :desc)
    res = user.tantous.joins(:katana).group('katanas.katana_type').count
    @rates = res.map{ |id, v| [id, v.to_f / res.values.sum] }.to_h

    res_by_recipe = user.tantous.joins(:katana).group('mokutan', 'tamahagane', 'reikyakuzai', 'toishi', 'katanas.katana_type').order('mokutan', 'tamahagane', 'reikyakuzai', 'toishi', 'katanas.katana_type').count
    @rates_by_recipe = res_by_recipe.map{ |id, v| [id, v.to_f / res.values.sum] }.to_h
  end
end
