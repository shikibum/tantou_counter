FactoryBot.define do
  factory :katana do
    name { '岩融' }
    katana_type { 7 }
    tantou_time { 300 }
    forgeable { true }
    rare { true }

    trait :unforgeable do
      name { '巴形薙刀' }
      tantou_time { 150 }
      forgeable { false }
    end

    trait :not_rare do
      name { '静形薙刀' }
      tantou_time { 100 }
      rare { false }
    end
  end
end
