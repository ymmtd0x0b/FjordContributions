# frozen_string_literal: true

class Users::WikisController < ApplicationController
  def index
    @repository = Repository.find_by(name: ENV['REPOSITORY_NAME'])
    @user = User.find_by(login: params[:user_login])
    @wikis = @user.wikis.order(:created_at)
  end
end
