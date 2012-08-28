class AddRekastColumnsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :rekast, :boolean, :default => false
  end
end
