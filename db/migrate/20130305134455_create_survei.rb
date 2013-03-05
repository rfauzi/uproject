class CreateSurvei < ActiveRecord::Migration
  def up
    create_table :survei do |t|
      t.integer     :user_id
      t.integer     :skill_level
      t.string      :bahasa_pemograman
      t.string      :cita_cita
      t.string      :minat_lain
      t.boolean     :laptop
      t.boolean     :akses_internet
      t.boolean     :wajib
      t.timestamps
    end
  end

  def down
    drop_table :survei
  end
end
