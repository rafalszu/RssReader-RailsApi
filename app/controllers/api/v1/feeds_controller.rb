# https://sourcey.com/building-the-prefect-rails-5-api-only-app/

class Api::V1::FeedsController < ApplicationController
    def index
        render json: Feed.all
    end
end
