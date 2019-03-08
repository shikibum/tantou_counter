# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    user = User.find_by(share_id: params[:id])
    @tantous = user&.tantous.where.not(katana_id: nil).order(created_at: :desc)
    res = user.tantous.joins(:katana).group('katanas.katana_type').count
    @rates = res.map{ |id, v| [id, v.to_f / res.values.sum] }.to_h
    @rares = user.tantous.joins(:katana).group('katanas.rare').count
    @rares_with_fuda = user.tantous.joins(:katana).group('katanas.rare').where(fuda: %i[梅 竹 松 富士]).count
    @rares_without_fuda = user.tantous.joins(:katana).group('katanas.rare').where(fuda: %i[なし]).count

    res_by_recipe = user.tantous.joins(:katana).group('mokutan', 'tamahagane', 'reikyakuzai', 'toishi').order('mokutan', 'tamahagane', 'reikyakuzai', 'toishi').count
    rares_by_recipe = user.tantous.joins(:katana).group('mokutan', 'tamahagane', 'reikyakuzai', 'toishi').order('mokutan', 'tamahagane', 'reikyakuzai', 'toishi').where(katanas: { rare: true }).count
    @tatal_by_recipe = res_by_recipe.map { |recipe, count|
                        rare_count = rares_by_recipe[recipe]
                        [recipe, { rare: rare_count, total: count, rate: rare_count.to_f/count}]
                       }.to_h

    res_by_recipe_with_fuda = user.tantous.joins(:katana).group('mokutan', 'tamahagane', 'reikyakuzai', 'toishi').order('mokutan', 'tamahagane', 'reikyakuzai', 'toishi').where(tantous: { fuda: %i[梅 竹 松 富士] }).count
    rares_by_recipe_with_fuda = user.tantous.joins(:katana).group('mokutan', 'tamahagane', 'reikyakuzai', 'toishi').order('mokutan', 'tamahagane', 'reikyakuzai', 'toishi').where(katanas: { rare: true }, tantous: { fuda: %i[梅 竹 松 富士] }).count
    @total_by_recipe_with_fuda = res_by_recipe_with_fuda.map { |recipe, count|
                                   rare_count = rares_by_recipe_with_fuda[recipe]
                                   [recipe, { rare: rare_count, total: count, rate: rare_count.to_f/count}]
                                 }.to_h

    res_by_recipe_without_fuda = user.tantous.joins(:katana).group('mokutan', 'tamahagane', 'reikyakuzai', 'toishi').order('mokutan', 'tamahagane', 'reikyakuzai', 'toishi').where(tantous: { fuda: %i[なし] }).count                             
    rares_by_recipe_without_fuda = user.tantous.joins(:katana).group('mokutan', 'tamahagane', 'reikyakuzai', 'toishi').order('mokutan', 'tamahagane', 'reikyakuzai', 'toishi').where(katanas: { rare: true }, tantous: { fuda: %i[なし] }).count
    @total_by_recipe_without_fuda = res_by_recipe_without_fuda.map { |recipe, count|
                                   rare_count = rares_by_recipe_without_fuda[recipe]
                                   [recipe, { rare: rare_count, total: count, rate: rare_count.to_f/count}]
                                 }.to_h
  end
end
