class AddIndexToReadStatuses < ActiveRecord::Migration
  def change
	add_index :read_statuses, [:user_id, :category_id]
	add_index :read_statuses, [:user_id]
	add_index :read_statuses, [:category_id]
  end
end
