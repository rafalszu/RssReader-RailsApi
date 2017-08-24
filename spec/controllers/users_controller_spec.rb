require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :api do
  johns_email = 'john@fake.address'
  johns_password = '123'

  it 'ensure it derives from AuthenticatedController' do
    expect(Api::V1::UsersController).to be < AuthenticatedController
  end

  before :all do
    # create a user, and login?
    @user = User.find_or_create_by(first_name: 'John', last_name: 'Doe01', email: johns_email)
    @user.create_login(identification: johns_email, password: johns_password, password_confirmation: johns_password)
  end

  describe 'POST /token' do
    params = { grant_type: 'password', username: johns_email, password: johns_password }
    headers = { "CONTENT_TYPE" => "application/x-www-form-urlencoded", "ACCEPT" => "application/json" }
    subject { post '/token', params, headers }

    context 'for grant_type = "PASSWORD"' do
      it 'responds with status 200' do
        subject

        expect(last_response.status).to eq(200)
      end

      it 'responds with an access token' do
        subject

        expect(last_response_as_json['access_token']).to eq(@user.login.oauth2_token)
      end
    end
  end
end
