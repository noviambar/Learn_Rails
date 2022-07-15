module Api
  module V1
    class ApiController < ActionController::Base
      protect_from_forgery with: :null_session

      SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

      def authentication
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
          @decoded = decode(header)
          @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { message: 'Please Login!' }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { message: 'Please Login!' }, status: :unauthorized
        end
      end

      def encode(payload, exp = 1.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY)
      end
    
      def decode(token)
        decoded = JWT.decode(token, SECRET_KEY)[0]
        HashWithIndifferentAccess.new decoded
      end
    end
  end
end