# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!
  helper_method :logged_in?, :current_user

  private

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def set_repository
    @repository = Repository.find(ENV['BOOTCAMP_REPOSITORY_ID'])
  end

  protected

  def authenticate_user!
    return if logged_in?

    redirect_to root_path, alert: 'ログインしてください'
  end
end
