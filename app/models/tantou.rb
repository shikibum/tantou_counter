# frozen_string_literal: true

class Tantou < ApplicationRecord
  belongs_to :kinji, class_name: 'Katana'
  belongs_to :katana

  validates :mokutan, inclusion: { in: 50..999 }
  validates :tamahagane, inclusion: { in: 50..999 }
  validates :reikyakuzai, inclusion: { in: 50..999 }
  validates :toishi, inclusion: { in: 50..999 }
end
