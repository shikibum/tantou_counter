class RenameFriganaColumnToKatanas < ActiveRecord::Migration[5.2]
  def change
    rename_column :katanas, :frigana, :furigana
  end
end
