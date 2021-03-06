module Overrides
  class TokenValidationsController < DeviseTokenAuth::TokenValidationsController
    OVERRIDE_PROOF = '(^^,)'

    def validate_token
      # @user will have been set by set_user_by_token concern
      if @user
        render json: {
          success: true,
          data: @user.as_json(except: [
            :tokens, :created_at, :updated_at
          ]),
          override_proof: OVERRIDE_PROOF
        }
      else
        render json: {
          success: false,
          errors: ["Invalid login credentials"]
        }, status: 401
      end
    end
  end
end
