# frozen_string_literal: true

class CurrentUsersController < ApplicationController
  before_action :set_repository, only: %i[update]

  def update
    ActiveRecord::Base.transaction do
      latest_user_data = GitHub::User.find_by(id: current_user.id)
      current_user.update!(latest_user_data.to_h)
      Newspaper.publish(:user_update, { repository: @repository, user: current_user })
      flash[:notice] = '更新に成功しました'
      redirect_back fallback_location: root_path
    end
  rescue Octokit::Error, ActiveRecord::StatementInvalid
    flash[:alert] = '更新に失敗しました'
    redirect_back fallback_location: root_path
  end

  def destroy
    ActiveRecord::Base.transaction do
      Newspaper.publish(:user_destroy, current_user)
      current_user.destroy!
    end
    reset_session
    redirect_to root_path, notice: 'アカウントを削除しました', status: :see_other
  rescue ActiveRecord::RecordNotDestroyed
    flash[:alert] = '削除に失敗しました'
    redirect_back fallback_location: root_path
  end
end
