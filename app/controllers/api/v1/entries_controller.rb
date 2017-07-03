module Api
  module V1
    class EntriesController < ApplicationController
      def index
        render json: Entry.all
      end

    end
  end
end
