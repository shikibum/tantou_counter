FactoryBot.define do
  factory :user do
    share_id { SecureRandom.hex(16) }
  end
end
