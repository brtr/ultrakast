class AddPostActionsCountToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :post_actions_count, :integer, :default => 0
  end
end
