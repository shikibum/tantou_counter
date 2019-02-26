class AddColumsToKatanas < ActiveRecord::Migration[5.2]
  def change
    add_column :katanas, :katana_type, :integer
    add_column :katanas, :tantou_time, :string
  end
end
