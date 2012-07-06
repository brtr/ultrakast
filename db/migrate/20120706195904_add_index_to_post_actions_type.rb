class AddIndexToPostActionsType < ActiveRecord::Migration
  def change
  	add_index :post_actions, :type
  end
end
