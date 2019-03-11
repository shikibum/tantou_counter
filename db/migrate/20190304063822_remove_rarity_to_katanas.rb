# frozen_string_literal: true

class RemoveRarityToKatanas < ActiveRecord::Migration[5.2]
  def change
    remove_column :katanas, :rarity, :integer
  end
end
