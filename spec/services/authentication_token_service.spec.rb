require 'rails_helper'

describe AuthenticationTokenService do
  describe '#call' do
    let(:token) { described_class.call }

    it 'should return authentication code' do
      decoded_token = JWT.decode(
        token,
        described_class::HMAC_SECRET,
        true,
        { algorithm: described_class::ALGORITHM_TYPE }
      )

      # described_call will check the Class on the toplevel describe block :]
      expect(decoded_token).to eq(
        [
          { 'test' => 'blah' },
          { 'alg' => 'HS256' }
        ]
      )
    end
  end
end
