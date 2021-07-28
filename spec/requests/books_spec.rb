require 'rails_helper'

describe 'Books API', type: :request do
  it 'return all books' do
    FactoryBot.create(:book, title: 'tittle1', author: 'author1')
    FactoryBot.create(:book, title: 'tittle2', author: 'author2')

    get '/api/v1/books'

    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(2)
  end
end
