require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it 'ensure it derives from AuthenticatedController' do
    expect(UsersController).to be < AuthenticatedController
  end
end
