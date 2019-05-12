# frozen_string_literal: true

class Tantou < ApplicationRecord
  belongs_to :kinji, class_name: 'Katana'
  belongs_to :katana, optional: true
  belongs_to :user

  validates :mokutan, numericality: { greater_than_or_equal_to: 50, less_than_or_equal_to: 999 }
  validates :tamahagane, numericality: { greater_than_or_equal_to: 50, less_than_or_equal_to: 999 }
  validates :reikyakuzai, numericality: { greater_than_or_equal_to: 50, less_than_or_equal_to: 999 }
  validates :toishi, numericality: { greater_than_or_equal_to: 50, less_than_or_equal_to: 999 }

  scope :with_fuda, -> { where(fuda: %i[梅 竹 松 富士]) }
  scope :without_fuda, -> { where(fuda: 'なし') }
end
