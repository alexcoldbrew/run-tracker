class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.string :date
      t.float :distance
      t.integer :hours
      t.integer :minutes
      t.integer :seconds
      t.integer :user_id
    end
  end
end
