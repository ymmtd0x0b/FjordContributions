# frozen_string_literal: true

class Users::ContributionsController < ApplicationController
  def index
    @repository = Repository.find_by(name: ENV['REPOSITORY_NAME'])
    @user = User.find_by(login: params[:user_login])
    @issues = @user.issues.order(:created_at)
    @assigned_issues = @user.assigned_issues.order(:created_at)
    @reviewed_issues = @user.reviewed_issues.order(:created_at)
    @wikis = @user.wikis.order(:created_at)
  end
end
