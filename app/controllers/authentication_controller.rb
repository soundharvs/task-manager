class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [ :register, :login ]

  def register
    user = User.new(user_params)
    if user.save
      render json: { message: "User registered successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = JWT.encode({ user_id: user.id, exp: 1.hours.from_now.to_i }, Rails.application.credentials.secret_key_base)
      render json: { token: token }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :phone, :status)
  end
end
