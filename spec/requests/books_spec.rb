require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET /books' do
    before do
      FactoryBot.create(:book, title: 'tittle1', author: 'author1')
      FactoryBot.create(:book, title: 'tittle2', author: 'author2')
    end

    it 'should return all books' do
      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /books' do
    it 'should create a new book' do
      expect do
        post '/api/v1/books', params: { book: { title: 'Martian', author: 'ETSD' } }
      end.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /books' do
    # The bang make sure the variable will be created before the test runs
    let!(:book) { FactoryBot.create(:book, title: 'tittle1', author: 'author1') }

    it 'should delete book' do
      expect do
        delete "/api/v1/books/#{book.id}"
      end.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
