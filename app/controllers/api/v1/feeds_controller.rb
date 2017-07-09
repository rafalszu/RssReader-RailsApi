# https://sourcey.com/building-the-prefect-rails-5-api-only-app/
module Api
  module V1
    class FeedsController < AuthenticatedController
      def index
        render json: Feed.all
      end
    end
  end
end
