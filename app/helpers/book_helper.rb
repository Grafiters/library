module BookHelper
    def required_params
        {
            author_id: Integer,
            title: String,
            tgl_publish: String,
            tgl_release: String,
            total_page: Integer,
            type_book: String
        }
    end
end
