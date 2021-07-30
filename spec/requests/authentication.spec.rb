require 'rails_helper'

describe 'Books API', type: :request do
  describe 'POST /authenticate' do
    it 'authenticates the client' do
      post '/api/v1/authenticate/', params: { username: 'BookSeller', password: 'asd654' }

      expect(response).to have_http_status(:created)
      expect(response_body).to eq(
        {
          'token' => '123'
        }
      )
    end

    it 'should return error when username is missing' do
      post '/api/v1/authenticate/', params: { password: 'asd654' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq(
        {
          'error' => 'param is missing or the value is empty: username'
        }
      )
    end

    it 'should return error when password is missing' do
      post '/api/v1/authenticate/', params: { username: 'BookSeller' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq(
        {
          'error' => 'param is missing or the value is empty: password'
        }
      )
    end
  end
end
