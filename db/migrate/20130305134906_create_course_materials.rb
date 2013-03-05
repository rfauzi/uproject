class CreateCourseMaterials < ActiveRecord::Migration
  def up
    create_table :course_materials do |t|
      t.integer   :course_id
      t.string    :title
      t.string    :descriptions
      t.timestamps
    end
  end

  def down
    drop_table :course_materials
  end
end
