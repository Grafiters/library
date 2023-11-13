class Api::BookController < ApplicationController
    def index
        default_params

        validation_params(params, nil, params_type)
        author = Author.find_by(uid: params[:author_uid]) unless params[:author_uid] != ""
        return render json: { error: 422, message: "Author not found" } unless params[:author_uid] == "" && author.blank?
        
        Book.order(title: :asc)
            .tap { |q| q.where!(type_book: params[:type_book]) if params[:type_book] != "" }
            .tap { |q| q.where!(uid: params[:uid]) if params[:uid] != "" }
            .tap { |q| q.where!(author_id: author[:id]) if params[:author_uid] != "" }
            .tap { |q| q.where!("title LIKE ?", params[:title]) if params[:title] != "" }
            .tap { |q| q.where!("tgl_publish = ?", Time.at(params[:tgl_publish])) if params[:tgl_publish] != 0 }
            .tap { |q| q.where!("tgl_publish >= ?", Time.at(params[:tgl_publish_start])) if params[:tgl_publish_start] != 0 && params[:tgl_publish] == 0 }
            .tap { |q| q.where!("tgl_publish <= ?", Time.at(params[:tgl_publish_end])) if params[:tgl_publish_end] != 0 && params[:tgl_publish] == 0 }
            .tap { |q| render json: paginate_response(q.page(params[:page]).per(params[:limit]), params[:page], params[:limit]) }
    rescue ArgumentError => e
        puts e.inspect
        return render json: e, status: 422
    end

    private

    def convert_params
        params[:tgl_publish] = params[:tgl_publish].to_i
    end

    def default_params
        params[:limit] = params[:limit] || 10
        params[:page] = params[:page] || 1
        params[:type_book] = params[:type_book] || ""
        params[:author_uid] = params[:author_uid] || ""
        params[:title] = params[:title] || ""
        params[:tgl_publish] = params[:tgl_publish].to_i || 0
        params[:tgl_publish_start] = params[:tgl_publish_start].to_i || 0
        params[:tgl_publish_end] = params[:tgl_publish_end].to_i || 0
        params[:uid] = params[:uid] || ""
    end

    def params_type
        expected_type = {
            limit: Integer,
            page: Integer,
            type_book: String,
            author_uid: String,
            title: String,
            tgl_publish: Integer,
            uid: String
        }
    end
end
