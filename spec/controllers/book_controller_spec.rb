require 'rails_helper'


RSpec.describe BookController, type: :controller do
  FactoryBot.define do
      factory :user do
          username { 'testing' }
          email { 'test@example.com' }
          password { 'password' }
      end
  end

  include Devise::Test::ControllerHelpers
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  after do
    DatabaseCleaner.clean # Assuming you're using DatabaseCleaner for cleaning up the database
  end
  
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    let(:author) { Author.create(name: 'Alone') }

    it 'returns a successful response' do
      get :form
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:author) { Author.create(name: 'Alone') }
    it 'creates a new book with additional attributes' do

      expect {
        post :create_or_update, params: {
          title: 'New Book',
          author_id: author.id,
          description: 'This is a great book',
          tgl_publish: Date.today.to_s,
          tgl_release: Date.tomorrow.to_s,
          total_page: 300,
          type_book: 'Fiction'
        }
      }.to change(Book, :count).by(1)
    end

    it 'redirects to the new book' do
      post :create_or_update, params: {
        title: 'New Book',
        author_id: author.id,
        description: 'This is a great book',
        tgl_publish: Date.today.to_s,
        tgl_release: Date.tomorrow.to_s,
        total_page: 300,
        type_book: 'Fiction'
      }

      expect(response).to redirect_to(book_index_path)
    end
  end

  describe 'GET #edit' do
    let(:author) { Author.create(name: 'Alone') }
    
    it 'returns a successful response' do
      params = {
          title: 'New Book',
          author_id: author.id,
          description: 'This is a great book',
          tgl_publish: Date.today.to_s,
          tgl_release: Date.tomorrow.to_s,
          total_page: 300,
          type_book: 'Fiction'
        }
      book = Book.create(params)

      patch :create_or_update, params: {
        id: book.id,
        author_id: author.id,
        title: 'Updated Book',
        description: 'Updated description',
        tgl_publish: Date.today.to_s,
        tgl_release: Date.tomorrow.to_s,
        total_page: 400,
        type_book: 'Non-Fiction'
      }

      get :form, params: { id: book.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    let(:author) { Author.create(name: 'Alone') }

    it 'updates the book with additional attributes' do
      params = {
        title: 'New Book',
        author_id: author.id,
        description: 'This is a great book',
        tgl_publish: Date.today.to_s,
        tgl_release: Date.tomorrow.to_s,
        total_page: 300,
        type_book: 'Fiction'
      }
      book = Book.create(params)

      patch :create_or_update, params: {
        id: book.id,
        author_id: author.id,
        title: 'Updated Book',
        description: 'Updated description',
        tgl_publish: Date.today.to_s,
        tgl_release: Date.tomorrow.to_s,
        total_page: 400,
        type_book: 'Non-Fiction'
      }

      expect(book.reload.title).to eq('Updated Book')
      expect(book.reload.description).to eq('Updated description')
      expect(book.reload.tgl_publish).to eq(Date.today)
      expect(book.reload.tgl_release).to eq(Date.tomorrow)
      expect(book.reload.total_page).to eq(400)
      expect(book.reload.type_book).to eq('Non-Fiction')
    end

    it 'redirects to the updated book' do
      params = {
        title: 'New Book',
        author_id: author.id,
        description: 'This is a great book',
        tgl_publish: Date.today.to_s,
        tgl_release: Date.tomorrow.to_s,
        total_page: 300,
        type_book: 'Fiction'
      }
      book = Book.create(params)

      patch :create_or_update, params: {
        id: book.id,
        author_id: author.id,
        title: 'Updated Book',
        description: 'Updated description',
        tgl_publish: Date.today.to_s,
        tgl_release: Date.tomorrow.to_s,
        total_page: 400,
        type_book: 'Non-Fiction'
      }

      expect(response).to redirect_to(book_index_url)
    end
  end

  describe 'DELETE #destroy' do
    let(:author) { Author.create(name: 'Alone') }
    it 'deletes the book' do
      params = {
        title: 'New Book',
        author_id: author.id,
        description: 'Updated description',
        tgl_publish: Date.today.to_s,
        tgl_release: Date.tomorrow.to_s,
        total_page: 400,
        type_book: 'Non-Fiction'
      }
      book = Book.create(params)

      patch :create_or_update, params: {
        id: book.id,
        author_id: author.id,
        title: 'Updated Book',
        description: 'Updated description',
        tgl_publish: Date.today.to_s,
        tgl_release: Date.tomorrow.to_s,
        total_page: 400,
        type_book: 'Non-Fiction'
      }
      expect {
        delete :destroy, params: { id: book.id }
      }.to change(Book, :count).by(-1)
    end

    it 'redirects to the books list' do
      params = {
        title: 'New Book',
        author_id: author.id,
        description: 'Updated description',
        tgl_publish: Date.today.to_s,
        tgl_release: Date.tomorrow.to_s,
        total_page: 400,
        type_book: 'Non-Fiction'
      }
      book = Book.create(params)

      patch :create_or_update, params: {
        id: book.id,
        author_id: author.id,
        title: 'Updated Book',
        description: 'Updated description',
        tgl_publish: Date.today,
        tgl_release: Date.tomorrow,
        total_page: 400,
        type_book: 'Non-Fiction'
      }
      delete :destroy, params: { id: book.id }
      expect(response).to redirect_to(book_index_path)
    end
  end
end