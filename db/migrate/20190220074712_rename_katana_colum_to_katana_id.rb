# frozen_string_literal: true

class RenameKatanaColumToKatanaId < ActiveRecord::Migration[5.2]
  def change
    rename_column :tantous, :kantana, :katana_id
  end
end
