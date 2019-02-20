class AddColumnToTantous < ActiveRecord::Migration[5.2]
  def change
    add_column :tantous, :user_id, :string
  end
end
