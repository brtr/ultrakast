class AddSharedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :shared, :boolean, :default => false
  end
end

