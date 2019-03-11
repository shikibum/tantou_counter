# frozen_string_literal: true

class AddFuriganaToKatana < ActiveRecord::Migration[5.2]
  def change
    add_column :katanas, :frigana, :string
  end
end
