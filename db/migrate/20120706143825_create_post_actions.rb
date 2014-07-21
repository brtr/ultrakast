class CreatePostActions < ActiveRecord::Migration
  def change
    create_table :post_actions do |t|
	  t.string  :type
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
