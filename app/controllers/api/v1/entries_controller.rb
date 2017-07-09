module Api
  module V1
    class EntriesController < AuthenticatedController
      def index
        render json: Entry.all
      end

    end
  end
end
