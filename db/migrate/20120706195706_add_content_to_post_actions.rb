class AddContentToPostActions < ActiveRecord::Migration
  def change
    add_column :post_actions, :content, :string
  end
end
