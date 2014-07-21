class CreateReadStatuses < ActiveRecord::Migration
  def change
    create_table :read_statuses do |t|
	  t.integer :user_id
      t.integer :category_id
	  t.datetime :last_read_time
      t.timestamps
    end
  end
end
