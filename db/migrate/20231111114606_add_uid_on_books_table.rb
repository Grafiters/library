class AddUidOnBooksTable < ActiveRecord::Migration[7.0]
  def up
    add_column :books, :uid, :string, limit: 75, null: false, after: :author_id
  end

  def down
    remove_column :books, :uid
  end
end
