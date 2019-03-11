FactoryBot.define do
  factory :tantou do
    user '1'
    kinji_id '1'
    mokutan '50'
    tamahagane '50'
    reikyakuzai '50'
    toishi '50'
    fuda 'なし'
    katana_id '2'

    factory :tantou_2 do
      katana_id '3'
    end

    factory :tantou_recipe_invalid do
      mokutan '1000'
    end
  end
end
