class CreateDownloadLinks < ActiveRecord::Migration
  def up
    create_table :download_links do |t|      
      t.string      :link
      t.string      :link_type
      t.string      :label
      t.timestamps
    end
  end

  def down
    drop_table :download_links
  end
end
