# frozen_string_literal: true

class Tantou < ApplicationRecord
  belongs_to :kinji, class_name: 'Katana'
  belongs_to :katana, optional: true
  belongs_to :user

  validates :mokutan, inclusion: { in: 50..999 }
  validates :tamahagane, inclusion: { in: 50..999 }
  validates :reikyakuzai, inclusion: { in: 50..999 }
  validates :toishi, inclusion: { in: 50..999 }

  attr_reader :all

  def all=(value)
    if value.present? && value > 0
      self.mokutan = value
      self.tamahagane = value
      self.reikyakuzai = value
      self.toishi = value
    end
  end
end
