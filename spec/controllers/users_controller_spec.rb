require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :api do
  johns_email = 'john@fake.address'
  johns_password = '123'

  it 'ensure it derives from AuthenticatedController' do
    expect(Api::V1::UsersController).to be < AuthenticatedController
  end

  before :all do
    # create a user, and login?
    u = User.create(first_name: 'John', last_name: 'Doe01', email: johns_email)
    u.create_login(identification: johns_email, password: johns_password, password_confirmation: johns_password)
  end

  # describe 'POST /token' do
  #   let(:params) { { grant_type: 'password', username: johns_email, password: johns_password } }
  #   subject { post '/token', params: params, headers: { 'HTTPS' => false } }

  #   context 'for grant_type = "PASSWORD"' do
  #     it 'responds with status 200' do
  #       subject

  #       puts subject
  #       expect(last_response).to have_http_status(200)
  #     end

  #     it 'responds with an access token' do
  #       subject

  #       expect(last_response.body).to be_json_eql({ access_token: login.oauth2_token }.to_json)
  #     end
  #   end
  # end
end
