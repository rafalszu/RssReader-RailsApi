# https://sourcey.com/building-the-prefect-rails-5-api-only-app/

class FeedsController < ApplicationController
    def index
        render json: Feed.all
    end
end
