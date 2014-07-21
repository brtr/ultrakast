class AddRekastColumnsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :rekast, :boolean, :default => false
	add_column :posts, :original_post, :integer
  end
end
