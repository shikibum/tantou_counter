# frozen_string_literal: true

class ChangeColumnToTantous < ActiveRecord::Migration[5.2]
  def change
    change_column :tantous, :user_id, 'integer USING CAST(user_id AS integer)'
  end
end
