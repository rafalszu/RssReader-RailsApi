require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  it 'ensure it derives from AuthenticatedController' do
    expect(Api::V1::UsersController).to be < AuthenticatedController
  end
end
