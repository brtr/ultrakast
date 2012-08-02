class AddIndexToCategoriesUsers < ActiveRecord::Migration
  def change
    add_index :categories_users, [:category_id]
	  add_index :categories_users, [:user_id]
  end
end
