class AddIndexToPosts < ActiveRecord::Migration
  def change
	add_index :posts, :user_id
	add_index :posts, :category_id
	add_index :posts, :created_at
	add_index :posts, :shared
  end
end
