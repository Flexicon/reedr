# frozen_string_literal: true

class CreateFeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :feeds do |t|
      t.string :title, null: false
      t.string :sub_title
      t.string :url, null: false
      t.references :user, null: false, foreign_key: true
      t.string :latest_id

      t.timestamps
    end
  end
end
