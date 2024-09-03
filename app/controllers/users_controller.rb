# frozen_string_literal: true

class UsersController < ApplicationController
  def update
    latest_user_data = GitHub::User.find_by(id: current_user.id)
    if latest_user_data && current_user.update!(latest_user_data.to_h)
      Newspaper.publish(:update_user, { repository: @repository, user: current_user })
      flash[:notice] = '更新しました'
    else
      flash[:alert] = '更新に失敗しました'
    end

    redirect_to request.headers[:HTTP_REFERER]
  end
end
