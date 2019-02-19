class CreateTantous < ActiveRecord::Migration[5.2]
  def change
    create_table :tantous do |t|
      t.integer :kinji_id
      t.integer :mokutan
      t.integer :tamahagane
      t.integer :reikyakuzai
      t.integer :toishi
      t.integer :fuda
      t.integer :kantana

      t.timestamps
    end
  end
end
