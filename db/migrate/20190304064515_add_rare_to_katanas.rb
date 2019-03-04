class AddRareToKatanas < ActiveRecord::Migration[5.2]
  def change
    add_column :katanas, :rare, :boolean, null: false, default: false
  end
end
