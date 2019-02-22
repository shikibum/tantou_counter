# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tantous

  validates :share_id, presence: true
end
