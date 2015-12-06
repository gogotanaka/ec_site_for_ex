class Api::BaseController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :authenticate_user_with_token!

  private
    def authenticate_user_with_token!
      if params[:user_email] && params[:user_token]
        if user = User.find_by(email: params[:user_email])
          if Devise.secure_compare(user.authentication_token, params[:user_token])
            sign_in user, store: false
          end
        end
      end
      unless current_user
        render json: { errors: "メールアドレスまたはトークンが間違っています" }, status: 401
      end
    end
end


# http://localhost:3000/api/v1/items.json?user_email=tanaka@tanaka.com&user_token=UTpEpAw1MWPhzzA5oyXw

# email + password    =>
#                     <= user_token1
# email + user_token1 =>
# email + user_token1 =>
#           ======= Accident ======
# email + password    =>
#                     <= user_token2
# email + user_token2 =>
# email + user_token2 =>
