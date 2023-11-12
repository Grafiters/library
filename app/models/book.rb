class Book < ApplicationRecord
    belongs_to :authors, class_name: "Author", foreign_key: :author_id, primary_key: :id

    before_validation :add_unique_identifier
    validates :author_id, :title, :description, :tgl_publish, :tgl_release, :total_page, :type_book, presence: true

    private

    def add_unique_identifier
        return if uid.present?
        self.uid = IdentifierService.new('BOOK').generate_uid
    end
end
