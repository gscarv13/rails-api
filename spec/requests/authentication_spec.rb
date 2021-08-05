require 'rails_helper'

describe 'Books API', type: :request do
  describe 'POST /authenticate' do
    let(:user) { FactoryBot.create(:user, username: 'BookSeller', password: 'asdasdasdasd') }
    it 'authenticates the client' do
      post '/api/v1/authenticate/', params: { username: user.username, password: 'asdasdasdasd' }

      expect(response).to have_http_status(:created)
      expect(response_body).to eq(
        {
          'token' => 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.DiPWrOKsx3sPeVClrm_j07XNdSYHgBa3Qctosdxax3w'
        }
      )
    end

    it 'should return error when username is missing' do
      post '/api/v1/authenticate/', params: { password: 'asdasdasdasd' }

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

    it 'returns error when password is wrong' do
      post '/api/v1/authenticate', params: { username: user.username, password: 'incorrect' }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
