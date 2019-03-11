# frozen_string_literal: true

class AddShareIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :share_id, :string
  end
end
