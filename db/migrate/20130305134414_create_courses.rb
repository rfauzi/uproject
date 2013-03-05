class CreateCourses < ActiveRecord::Migration
  def up
    create_table :courses do |t|
      t.string :user_id
      t.string :lecturer_id
      t.string :title
      t.string :descriptions
      t.timestamps
    end
  end

  def down
    drop_table :courses
  end
end
