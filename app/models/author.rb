class Author < ApplicationRecord
    has_many :books

    before_validation :add_unique_identifier
    validates :uid, :name, presence: true

    def required_params
        {
            name: String
        }
    end

    private

    def add_unique_identifier
        return if uid.present?
        self.uid = IdentifierService.new('AUT').generate_uid
    end
end
