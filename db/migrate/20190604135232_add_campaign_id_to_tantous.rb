# frozen_string_literal: true

class AddCampaignIdToTantous < ActiveRecord::Migration[5.2]
  def change
    add_column :tantous, :campaign_id, :integer
  end
end
