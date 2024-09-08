# frozen_string_literal: true

class CurrentUserController < ApplicationController
  include Settable
  before_action :set_repository, only: %i[update]

  def update
    latest_user_data = GitHub::User.find_by(id: current_user.id)
    if latest_user_data && current_user.update!(latest_user_data.to_h)
      Newspaper.publish(:update_user, { repository: @repository, user: current_user })
      flash[:notice] = '更新に成功しました'
    else
      flash[:alert] = '更新に失敗しました'
    end

    redirect_to request.headers[:HTTP_REFERER]
  end

  def destroy
    Newspaper.publish(:user_destroy, current_user)
    current_user.destroy!
    reset_session
    redirect_to root_path, notice: 'アカウントを削除しました', status: :see_other
  end
end
