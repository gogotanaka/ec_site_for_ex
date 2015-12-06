class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate_user_with_token!, only: [:create]
  def create
    if params[:email] && params[:password]
      @user = User.find_by(email: params[:email])
      if @user && @user.valid_password?(params[:password])
        @user.ensure_authentication_token if @user.authentication_token.blank?
        render json: { user_token: @user.authentication_token }, status: 200
      else
        render json: { errors: "メールアドレスまたはパスワードが間違っています。" }, status: 400
      end
    else
      render json: { errors: "不正なパラメーターです。" }, status: 400
    end
  end
end
