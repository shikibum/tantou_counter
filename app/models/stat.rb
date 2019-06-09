class Stat
  def initialize(user, campaign)
    @user = user
    @campaign = campaign
  end

  def rates
    return @rates if @rates
    res = tantous.joins(:katana).group('katanas.katana_type').count
    @rates = res.map { |id, v| [id, v.to_f / res.values.sum] }.to_h
  end

  def rares_with_fuda
    return @rares_with_fuda if @rares_with_fuda

    count = tantous.rare_katana.with_fuda.count
    total = tantous.with_fuda.count
    @rares_with_fuda = {
      count: count,
      total: total,
      rate: ((count.to_f / total) * 100).round(1)
    }
  end

  def rares_without_fuda
    return @rares_without_fuda if @rares_without_fuda

    count = tantous.rare_katana.without_fuda.count
    total = tantous.without_fuda.count
    @rares_without_fuda = {
      count: count,
      total: total,
      rate: ((count.to_f / total) * 100).round(1)
    }
  end

  def total_by_recipe_with_fuda
    @total_by_recipe_with_fuda ||= retrieve_total_by_recipe_with_fuda
  end

  def total_by_recipe_without_fuda
    @total_by_recipe_without_fuda ||= retrieve_total_by_recipe_without_fuda
  end

  def total_by_recipe
    @total_by_recipe ||= calculate_total_by_recipe(total_by_recipe_with_fuda, total_by_recipe_without_fuda)
  end

  def tantous
    @tantous ||= @user.tantous.for_campaign(@campaign).where.not(katana_id: nil)
  end

  private

  def retrieve_total_by_recipe_with_fuda
    res_by_recipe_with_fuda = tantous.group_by_shizai.order_by_shizai.with_fuda.count
    rares_by_recipe_with_fuda = tantous.rare_katana.group_by_shizai.order_by_shizai.with_fuda.count
    res_by_recipe_with_fuda.map do |recipe, count|
      rare_count = rares_by_recipe_with_fuda[recipe]
      [recipe, { rare: rare_count.to_i, total: count, rate: rare_count.to_f / count }]
    end.to_h
  end

  def retrieve_total_by_recipe_without_fuda
    res_by_recipe_without_fuda = tantous.group_by_shizai.order_by_shizai.without_fuda.count
    rares_by_recipe_without_fuda = tantous.rare_katana.group_by_shizai.order_by_shizai.without_fuda.count
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
