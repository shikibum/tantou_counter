# frozen_string_literal: true

class ChangeColumnToKatanas < ActiveRecord::Migration[5.2]
  def change
    change_column :katanas, :tantou_time, 'integer USING CAST(tantou_time AS integer)'
  end
end
