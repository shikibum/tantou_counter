# frozen_string_literal: true

class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end
end
