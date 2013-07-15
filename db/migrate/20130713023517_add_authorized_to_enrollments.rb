class AddAuthorizedToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :authorized, :boolean, default: false
  end
end
