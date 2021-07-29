require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  it 'should have a max limit of 100' do
    # #and_call_original will mock a call and keep going with the code execution
    # without returning a value
    expect(Book).to receive(:limit).with(100).and_call_original

    # should get action, not route :]
    get :index, params: { limit: 999 }
  end
end
