# frozen_string_literal: true

class Users::ContributionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :set_repository, only: %i[index]

  def index
    @user = User.find_by(login: params[:user_login])
    @issues = @user.issues.includes(:repository).order(:created_at)
    @assigned_issues = @user.assigned_issues.includes(%i[repository pull_requests]).order(:created_at)
    @reviewed_issues = @user.reviewed_issues.includes(%i[repository pull_requests]).order(:created_at)
    @wikis = @user.wikis.includes(:repository).order(:created_at)
  end
end
