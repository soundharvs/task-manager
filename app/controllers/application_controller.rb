class ApplicationController < ActionController::API
  before_action :authenticate_request
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  private

  def authenticate_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    begin
      decoded = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: "HS256")
      @current_user = User.find(decoded[0]["user_id"])
    rescue JWT::DecodeError
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end

  def not_found
    render json: { error: "Record not found" }, status: :not_found
  end

  def invalid_record(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
