module Api
  module V1
    class ProfilesController < ApiController
      before_action :authentication, except: [:create]
      before_action :find_user, except: %i[create index]

      # skip_before_action :verify_authenticity_token

      def index
        @profiles = User.all
        render json: @profiles, status: :ok
      end

      def show
        render json: @profile, status: :ok
      end

      def create
        @profile = User.new(profile_params)
        if @profile.save
          render json: @user, status: :created
        else
          render json: { errors: @profile.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      private
      def profile_params
        params.permit(:name, :email, :mobile, :password)
      end

      def find_user
        @profile = User.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: { errors: 'User Not Found'}
        end
    end
  end
end