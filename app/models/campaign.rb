# frozen_string_literal: true

class Campaign < ApplicationRecord
  has_many :tantous

  scope :active, -> { where('start_at <= ?', Time.current) }

  def self.latest
    active.order(start_at: :desc).first
  end
end
