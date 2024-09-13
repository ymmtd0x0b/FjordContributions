# frozen_string_literal: true

class CurrentUser::ContributionsController < ApplicationController
  before_action :set_repository, only: %i[index]

  def index
    @issues = current_user.issues.includes(:repository).order(:created_at)
    @assigned_issues = current_user.assigned_issues.includes(%i[repository pull_requests]).order(:created_at)
    @reviewed_issues = current_user.reviewed_issues.includes(%i[repository pull_requests]).order(:created_at)
    @wikis = current_user.wikis.includes(:repository).order(:created_at)
  end
end
