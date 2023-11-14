class AuthorController < ApplicationController
    before_action :authenticate_user!, only: [:form, :create_or_update, :show, :destroy]
    before_action :admin_permission!, only: [:form, :create_or_update, :show, :destroy]

    def index
        @authors = Author.all
        @author_data = nil
    end

    def form
        @author_data = nil
        if params[:id].present?
            @author_data = Author.find(params[:id])
            unless @author_data
                flash[:error] = "Author not found"
            end
        end
    end

    def create_or_update
        validation_params(params, Author.required_params)
        author = params[:id] != '' ? Author.find(params[:id]) : Author.new
        if params[:id] && author.blank?
            flash[:error] = "Author not found"
        end

        if params[:id] != '' && author.update(author_params)
            redirect_to author_index_url, notice: 'Post was successfully saved.'
        elsif author.update(author_params)
            redirect_to author_index_url, notice: 'Post was successfully saved.'
        end
    rescue => e
        flash[:error] = e
    end

    def show
        @author = Author.find(params[:id])
        unless @author
            flash[:error] = "Author not found"
        end

        @book = Book.where(author_id: @author[:id])
    end

    def destroy
        author = Author.find(params[:id])
        unless @author
            flash[:error] = "Author not found"
        end

        book = Book.where(author_id: author)
        unless book
            book.destroy_all
        end

        redirect_to asistens_path, :notice => "Successfully deleted data author"
    end

    private

    def validate_author
        author = Author.find_by(name: params[:name])
        raise "Author already saved" if author.present?
        return nil
    end

    def author_params
        params.permit(:name)
    end
end
