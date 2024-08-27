# frozen_string_literal: true

module Settable
  extend ActiveSupport::Concern

  def set_repository
    @repository = Repository.find_by(name: ENV['REPOSITORY_NAME'])
  end

  def set_user
    @user = User.find_by(login: params[:user_login])
  end
end
