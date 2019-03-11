# frozen_string_literal: true

class Tantou < ApplicationRecord
  belongs_to :kinji, class_name: 'Katana'
  belongs_to :katana, optional: true
  belongs_to :user

  validates :mokutan, numericality: { greater_than_or_equal_to: 50, less_than_or_equal_to: 999 }
  validates :tamahagane, numericality: { greater_than_or_equal_to: 50, less_than_or_equal_to: 999 }
  validates :reikyakuzai, numericality: { greater_than_or_equal_to: 50, less_than_or_equal_to: 999 }
  validates :toishi, numericality: { greater_than_or_equal_to: 50, less_than_or_equal_to: 999 }

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
