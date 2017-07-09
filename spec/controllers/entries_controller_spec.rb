require 'rails_helper'

RSpec.describe Api::V1::EntriesController, type: :controller do
  it 'ensure it derives from AuthenticatedController' do
    expect(Api::V1::EntriesController).to be < AuthenticatedController
  end
end
