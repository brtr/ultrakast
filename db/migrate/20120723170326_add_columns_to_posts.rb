class AddColumnsToPosts < ActiveRecord::Migration
  def change
	add_column :posts, :likes_count, :integer, :default => 0
    add_column :posts, :favorites_count, :integer, :default => 0
	add_column :posts, :comments_count, :integer, :default => 0
  end
end
