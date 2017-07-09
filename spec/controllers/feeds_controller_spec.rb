require 'rails_helper'

RSpec.describe Api::V1::FeedsController, type: :controller do
  it 'ensure it derives from AuthenticatedController' do
    expect(Api::V1::FeedsController).to be < AuthenticatedController
  end
end
