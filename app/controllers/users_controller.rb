# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    user = User.find_by(share_id: params[:id])
    latest_campaign = Campaign.order(start_at: :asc).last
    @tantous = user&.tantous.where(campaign_id: latest_campaign.id).where.not(katana_id: nil).order(created_at: :desc)
    res = user.tantous.where(campaign_id: latest_campaign.id).joins(:katana).group('katanas.katana_type').count
    @rates = res.map { |id, v| [id, v.to_f / res.values.sum] }.to_h
    @rares_with_fuda = user.tantous.where(campaign_id: latest_campaign.id).rare_katana.with_fuda.count
    @rares_without_fuda = user.tantous.where(campaign_id: latest_campaign.id).rare_katana.without_fuda.count

    # {[50, 50] => { rare: 3, total: 10, rate: 0.33333 } }
    @total_by_recipe_with_fuda = retrieve_total_by_recipe_with_fuda(user, latest_campaign)

    @total_by_recipe_without_fuda = retrieve_total_by_recipe_without_fuda(user, latest_campaign)

    # {[50, 50] => {fuda: { rare: 3, total: 10, rate: 0.33333 }, without_fuda: { rare: 3, total: 10, rate: 0.33333 }}
    @total_by_recipe = calculate_total_by_recipe(@total_by_recipe_with_fuda, @total_by_recipe_without_fuda)
  end

  private

  def retrieve_total_by_recipe_with_fuda(user, campaign)
    res_by_recipe_with_fuda = user.tantous.where(campaign_id: campaign.id).group_by_shizai.order_by_shizai.with_fuda.count
    rares_by_recipe_with_fuda = user.tantous.where(campaign_id: campaign.id).rare_katana.group_by_shizai.order_by_shizai.with_fuda.count
    res_by_recipe_with_fuda.map do |recipe, count|
      rare_count = rares_by_recipe_with_fuda[recipe]
      [recipe, { rare: rare_count.to_i, total: count, rate: rare_count.to_f / count }]
    end.to_h
  end

  def retrieve_total_by_recipe_without_fuda(user, campaign)
    res_by_recipe_without_fuda = user.tantous.where(campaign_id: campaign.id).group_by_shizai.order_by_shizai.without_fuda.count
    rares_by_recipe_without_fuda = user.tantous.where(campaign_id: campaign.id).rare_katana.group_by_shizai.order_by_shizai.without_fuda.count
    res_by_recipe_without_fuda.map do |recipe, count|
      rare_count = rares_by_recipe_without_fuda[recipe]
      [recipe, { rare: rare_count.to_i, total: count, rate: rare_count.to_f / count }]
    end.to_h
  end

  def calculate_total_by_recipe(total_by_recipe_with_fuda, total_by_recipe_without_fuda)
    recipes = (total_by_recipe_with_fuda.keys + total_by_recipe_without_fuda.keys).uniq
    recipes.map do |recipe|
      with_fuda = total_by_recipe_with_fuda[recipe]
      without_fuda = total_by_recipe_without_fuda[recipe]
      [recipe, { with_fuda: with_fuda, without_fuda: without_fuda }]
    end.to_h
  end
end
