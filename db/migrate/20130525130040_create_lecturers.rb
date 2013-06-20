class CreateLecturers < ActiveRecord::Migration
  def up
    create_table :lecturers do |t|
      t.integer   :user_id
      t.timestamps
    end
  end

  def down
    drop_table :lecturers
  end
end
