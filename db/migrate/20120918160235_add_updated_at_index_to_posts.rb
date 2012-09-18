class AddUpdatedAtIndexToPosts < ActiveRecord::Migration
  def change
	add_index :posts, [:updated_at]
  end
end
