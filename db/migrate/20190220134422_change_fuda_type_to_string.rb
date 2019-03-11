# frozen_string_literal: true

class ChangeFudaTypeToString < ActiveRecord::Migration[5.2]
  def change
    change_column :tantous, :fuda, :string
  end
end
