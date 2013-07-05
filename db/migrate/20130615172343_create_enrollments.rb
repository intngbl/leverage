class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :user_id
      t.integer :campaign_id

      t.timestamps
    end

    add_index :enrollments, :user_id
    add_index :enrollments, :campaign_id
    add_index :enrollments, [:user_id, :campaign_id], unique: true
  end
end
