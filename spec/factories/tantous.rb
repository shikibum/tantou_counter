# frozen_string_literal: true

FactoryBot.define do
  factory :tantou do
    user
    kinji { create(:katana) }
    mokutan { 50 }
    tamahagane { 50 }
    reikyakuzai { 50 }
    toishi { 50 }
    fuda { 'なし' }
    katana { create(:katana) }

    trait :recipe_invalid do
      mokutan { 1000 }
    end
  end
end
