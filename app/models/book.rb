class Book < ApplicationRecord
    belongs_to :authors, class_name: "Author", foreign_key: :author_id, primary_key: :id

    before_validation :add_unique_identifier
    validates :author_id, :title, :description, :tgl_publish, :tgl_release, :total_page, :type_book, presence: true

    after_create :send_mail_to_all

    private

    def send_mail_to_all
        user = User.all
        param_mail = {
            user: nil,
            title: 'New Book',
            subject: 'New Book Library',
            content: as_json_data,
            template: 'book'
        }

        EmailWorker.perform_async(param_mail[:user], param_mail[:title], param_mail[:subject], param_mail[:content], param_mail[:template])
    end

    def add_unique_identifier
        return if uid.present?
        self.uid = IdentifierService.new('BOOK').generate_uid
    end

    def as_json_data
        {
            uid: uid,
            title: title,
            description: description,
            author: authors.name,
            tgl_publish: tgl_publish,
            total_page: total_page,
            created_at: created_at
        }
    end
end
