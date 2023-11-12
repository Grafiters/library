class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.references  :author, index: true, null: false, foreign_key: true
      t.string      :title, null: false
      t.text        :description, null: true
      t.string      :upload, null: true
      t.date        :tgl_publish
      t.date        :tgl_release
      t.integer     :total_page, default: 0
      t.string      :type_book, default: 'book', comment: '[book e-book]'

      t.timestamps
    end
  end
end