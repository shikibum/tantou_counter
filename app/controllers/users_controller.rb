# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    user = User.find_by(share_id: params[:id])
    @tantous = user&.tantous.where.not(katana_id: nil).order(created_at: :desc)
    res = user.tantous.joins(:katana).group('katanas.katana_type').count
    @rates = res.map { |id, v| [id, v.to_f / res.values.sum] }.to_h
    @rares_with_fuda = user.tantous.rare_katana.with_fuda.count
    @rares_without_fuda = user.tantous.rare_katana.without_fuda.count

    # {[50, 50] => { rare: 3, total: 10, rate: 0.33333 } }
    res_by_recipe_with_fuda = user.tantous.group_by_shizai.order('mokutan', 'tamahagane', 'reikyakuzai', 'toishi').with_fuda.count
    rares_by_recipe_with_fuda = user.tantous.rare_katana.group_by_shizai.order('mokutan', 'tamahagane', 'reikyakuzai', 'toishi').with_fuda.count
    @total_by_recipe_with_fuda = res_by_recipe_with_fuda.map do |recipe, count|
      rare_count = rares_by_recipe_with_fuda[recipe]
      [recipe, { rare: rare_count.to_i, total: count, rate: rare_count.to_f / count }]
    end.to_h

    res_by_recipe_without_fuda = user.tantous.group_by_shizai.order('mokutan', 'tamahagane', 'reikyakuzai', 'toishi').without_fuda.count
    rares_by_recipe_without_fuda = user.tantous.rare_katana.group_by_shizai.order('mokutan', 'tamahagane', 'reikyakuzai', 'toishi').without_fuda.count
    @total_by_recipe_without_fuda = res_by_recipe_without_fuda.map do |recipe, count|
      rare_count = rares_by_recipe_without_fuda[recipe]
      [recipe, { rare: rare_count.to_i, total: count, rate: rare_count.to_f / count }]
    end.to_h
    # {[50, 50] => {fuda: { rare: 3, total: 10, rate: 0.33333 }, without_fuda: { rare: 3, total: 10, rate: 0.33333 }}
    recipes = (@total_by_recipe_with_fuda.keys + @total_by_recipe_without_fuda.keys).uniq
    @total_by_recipe = recipes.map do |recipe|
      with_fuda = @total_by_recipe_with_fuda[recipe]
      without_fuda = @total_by_recipe_without_fuda[recipe]
      [recipe, { with_fuda: with_fuda, without_fuda: without_fuda }]
    end.to_h
  end
end
