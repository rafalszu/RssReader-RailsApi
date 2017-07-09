module Api
  module V1
    class UsersController < AuthenticatedController
      def me
        render json: current_login.user, serializer: UserSerializer
      end
    end
  end
end
