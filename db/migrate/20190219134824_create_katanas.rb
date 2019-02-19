class CreateKatanas < ActiveRecord::Migration[5.2]
  def change
    create_table :katanas do |t|
      t.string :name
      t.integer :rarity
      
      t.timestamps
    end
  end
end
