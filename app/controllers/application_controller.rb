# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :logged_in?, :current_user

  private

  def logged_in?
    !!session[:user_id] && User.find_by(id: session[:user_id])
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
