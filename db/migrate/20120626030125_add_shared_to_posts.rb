class AddSharedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :shared, :boolean, :default => 0
  end
end

