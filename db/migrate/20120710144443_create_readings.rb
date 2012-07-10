class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
	  t.string  :readable_type
	  t.integer :readable_id
	  t.integer :user_id
      t.timestamps
    end
  end
end
