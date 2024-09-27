class AddStatusFieldsToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :published_at, :time
    add_column :posts, :archived_at, :time

    add_index :posts, :published_at
    add_index :posts, :archived_at
  end
end
