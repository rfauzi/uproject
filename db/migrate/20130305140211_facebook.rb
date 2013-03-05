class Facebook < ActiveRecord::Migration
  def up
    create_table :facebook do |t|
      t.string :uid
      t.string :access_token
      t.timestamps
    end
  end

  def down
    drop_table :facebook
  end
end
