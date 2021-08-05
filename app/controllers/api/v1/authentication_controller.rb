module Api
  module V1
    class AuthenticationController < ApplicationController
      class AuthenticationError < StandardError; end

      rescue_from ActionController::ParameterMissing, with: :paramenter_missing
      rescue_from AuthenticationError, with: :handle_unauthenticated

      def create
        raise AuthenticationError unless user.authenticate(params.require(:password))

        token = AuthenticationTokenService.call(user.id)

        render json: { token: token }, status: :created
      end

      def user
        @user ||= User.find_by(username: params.require(:username))
      end

      private

      def paramenter_missing(error)
        render json: { error: error.original_message }, status: :unprocessable_entity
      end

      def handle_unauthenticated
        head :unauthorized
      end
    end
  end
end
