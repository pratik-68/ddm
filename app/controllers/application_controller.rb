# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit
  # protect_from_forgery
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :authorized

  private

  def success_response(json_data)
    render(json: json_data, status: 200)
  end

  def create_response(json_data)
    render(json: json_data, status: 201)
  end

  def bad_response(json_data)
    render(json: { error: json_data }, status: 400)
  end

  def unauthorized_response(json_data)
    render(json: json_data, status: 401)
  end

  def forbidden_response(json_data = {error: { message: 'Not Allowed' }})
    render(json: json_data, status: 403)
  end

  def not_found_response(json_data = { error: { message: 'Not Found' } })
    render(json: json_data, status: 404)
  end

  def service_unavailable(json_data)
    render(json: json_data, status: 503)
  end

  def authorized
    # if true => login
    unauthorized_response(error: { message: 'Please log in' }) unless logged_in?
  end

  def logged_in?
    validate_token?
  end

  def current_user
    @current_user
  end

  def validate_token?
    return unless request.headers[:token]

    token = Token.find_by(token: request.headers[:token])
    return unless token.present? && token.last_used_on <= Time.current + 1.day

    token.update(last_used_on: Time.current)
    @current_user = token.user
    true
  end

  def buyer?(user)
    user.buyer? || both?(user)
  end

  def seller?(user)
    user.seller? || both?(user)
  end

  def both?(user)
    user.both?
  end

  def user_not_authorized
    forbidden_response
  end
end
