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

  it 'returns token after passing all required params' do
    post_params = { grant_type: 'password', username: johns_email, password: johns_password }
    post '/token', post_params

    puts last_response.body
    true
  end
end
