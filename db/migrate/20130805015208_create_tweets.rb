class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :body
      t.timestamp :tweeted_at
      t.boolean :authorized, default: false
      t.integer :tweeter_id
      t.integer :campaign_id
      t.timestamps
    end
    add_index :tweets, :campaign_id
  end
end
