class AddIndexToPostActions < ActiveRecord::Migration
  def change
  	add_index :post_actions, [:type]
	add_index :post_actions, [:post_id]
	add_index :post_actions, [:user_id]
  end
end
