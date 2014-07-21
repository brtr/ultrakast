class CreateTutors < ActiveRecord::Migration
  def up
    create_table :tutors do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.timestamps
    end

    create_table :categories_tutors do |t|
    	t.references :tutor
    	t.references :category
    end

    add_index :categories_tutors, [:tutor_id, :category_id]
  end

  def down
    drop_table :tutors
    drop_table :courses_tutors
  end
end
