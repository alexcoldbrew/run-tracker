class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.string :date
      t.float :distance
      t.integer :hours
      t.integer :minutes
      t.integer :seconds
      # will be able to convert hours to minutes and determine average pace for the distance I believe
    end
  end
end
