class CreateMessages < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.integer   :user_id
      t.string    :message
      t.timestamps
    end
  end

  def down
  end
end
