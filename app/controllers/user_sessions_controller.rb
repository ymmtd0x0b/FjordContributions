# frozen_string_literal: true

class UserSessionsController < ApplicationController
  def create
    user = User.find_or_initialize_by_github_auth(request.env['omniauth.auth'])
    user.save if user.new_record?
    session[:user_id] = user.id
    redirect_to users_issues_path(current_user.login, association: 'assigned')
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
