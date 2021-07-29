require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET /books' do
    let(:author_one) { FactoryBot.create(:author, first_name: 'Jester', last_name: 'Wiggins', age: '32') }

    before do
      FactoryBot.create(:book, title: 'title1', author: author_one)
      FactoryBot.create(:book, title: 'title2', author: author_one)
    end

    it 'should return all books' do
      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
      expect(JSON.parse(response.body)).to eq(
        [
          {
            'id' => 1,
            'title' => 'title1',
            'author_name' => 'Jester Wiggins',
            'author_age' => 32
          },
          {
            'id' => 2,
            'title' => 'title2',
            'author_name' => 'Jester Wiggins',
            'author_age' => 32
          }
        ]
      )
    end
  end

  describe 'POST /books' do
    it 'should create a new book' do
      expect do
        post '/api/v1/books', params: {
          book: { title: 'The Martian' },
          author: { first_name: 'Andy', last_name: 'Weir', age: '48' }
        }
      end.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(Author.count).to eq(1)
      expect(JSON.parse(response.body)).to eq(
        {
          'id' => 1,
          'title' => 'The Martian',
          'author_name' => 'Andy Weir',
          'author_age' => 48
        }
      )
    end
  end

  describe 'DELETE /books' do
    # The bang make sure the variable will be created before the test runs
    let!(:book) do
      FactoryBot.create(:author, first_name: 'Andy', last_name: 'Weir', age: '48')
      FactoryBot.create(:book, title: 'tittle1', author_id: 1)
    end

    it 'should delete book' do
      expect do
        delete "/api/v1/books/#{book.id}"
      end.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
