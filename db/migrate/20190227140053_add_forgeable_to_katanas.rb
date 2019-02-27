class AddForgeableToKatanas < ActiveRecord::Migration[5.2]
  def change
      add_column :katanas, :forgeable, :boolean, null: false, default: true
  end
end
