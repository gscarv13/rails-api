module Api
  module V1
    class AuthenticationController < ApplicationController
      rescue_from ActionController::ParameterMissing, with: :paramenter_missing

      def create
        params.require(:username)
        params.require(:password)

        render json: { token: '123' }, status: :created
      end

      private

      def paramenter_missing(error)
        render json: { error: error.original_message }, status: :unprocessable_entity
      end
    end
  end
end
