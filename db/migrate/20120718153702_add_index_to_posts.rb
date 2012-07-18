class AddIndexToPosts < ActiveRecord::Migration
  def change
	add_index :posts, :user_id
	add_index :posts, :category_id
  end
end
