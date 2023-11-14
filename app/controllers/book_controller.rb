include BookHelper
class BookController < ApplicationController
    before_action :authenticate_user!, only: [:form, :create_or_update, :show, :destroy]
    before_action :admin_permission!, only: [:form, :create_or_update, :show, :destroy]
    
    def index
        params[:page] = params[:page] || 1
        params[:max_pages] = params[:max_pages] || 1
        @books = Book.page(params[:page]).per(params[:max_pages])
        @book_id = nil
    end

    def form
        @book_id = nil
        @author = Author.all
        if params[:id].present?
            @book_id = Book.find(params[:id])
            unless @book_id
                flash[:error] = "Book not found"
            end

            @author = Author.find_by(id: @book_id[:author_id])
        end
    end

    def create_or_update
        convert_params
        validation_params(params, required_params, nil)
        @author = Author.all

        author = Author.find_by(id: params[:author_id])
        if author.blank?
            flash[:error] = "Author not found"
        end

        validate_book = Book.find_by(book_params)
        unless validate_book.blank?
            flash[:error] = "Book already exists"
            return render :form, status: 422
        end

        book = params[:id].present? && params[:id] != '' ? Book.find(params[:id]) : Book.new
        if params[:id].present? && params[:id] && Book.blank?
            flash[:error] = "Book not found"
            return render :form, status: 422
        end

        if params[:id].present? && params[:id] != '' && Book.update(book_params)
            redirect_to book_index_url, notice: 'Book was successfully saved.'
        else 
            book = Book.new(book_params)
            if book.save
                redirect_to book_index_url
            else
                flash[:error] = book.errors.as_json
                return render :form, status: 422
            end
        end
    rescue ArgumentError => e
        puts e.inspect
        @author = Author.all
        flash[:error] = e
        return render :form, status: 422
    end

    def destroy
        book = Book.find(params[:id])
        unless book
            flash[:error] = "Book not found"
        end

        book.destroy

        redirect_to book_index_path, :notice => "Successfully deleted data Book"
    end

    private
    def convert_params
        params[:author_id] = params[:author_id].to_i
        params[:total_page] = params[:total_page].to_i
    end

    def book_params
        params.permit(:author_id, :title, :description, :tgl_publish, :tgl_release, :total_page, :type_book)
    end
end
