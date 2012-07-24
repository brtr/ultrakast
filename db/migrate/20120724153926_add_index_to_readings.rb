class AddIndexToReadings < ActiveRecord::Migration
  def change
    add_index :readings, [:user_id]
	add_index :readings, [:readable_id]
  end
end
