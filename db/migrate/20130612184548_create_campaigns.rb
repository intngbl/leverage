class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.integer :user_id
      t.text :brief
      t.decimal :price

      t.timestamps
    end
    add_index :campaigns, [:user_id, :created_at]
  end
end
