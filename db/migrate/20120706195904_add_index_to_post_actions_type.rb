class AddIndexToPostActionsType < ActiveRecord::Migration
  def change
  	add_index :post_actions, [:type, :post_id, :user_id]
  end
end
