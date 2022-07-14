module Api
  module V1
    class AuthController < ApiController
      before_action :authorize_request, except: :login
      skip_before_action :verify_authenticity_token

      def login
        @profile = User.find_by_email(params[:email])
        if @profile&.authenticate(params[:password])
          token = encode(user_id: @profile.id)
          time = Time.now + 1.hours.to_i
          render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), name: @profile.name, id: @profile.id }, status: :ok
        else
          render json: { error: 'unauthorized'}, status: :unauthorized
        end
      end

      private

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end 