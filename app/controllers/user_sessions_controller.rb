# frozen_string_literal: true

class UserSessionsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_repository, only: %i[create]

  def create
    user = User.find_or_initialize_by_github_auth(request.env['omniauth.auth'])
    if user.new_record?
      user.save!
      flash[:account_registration] = 'ようこそ！'
    else
      flash[:notice] = 'ログインしました'
    end
    session[:user_id] = user.id
    redirect_to current_user_issues_path(association: 'assigned')
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end

  def failure
    redirect_to root_path, alert: '認証に失敗しました'
  end
end
