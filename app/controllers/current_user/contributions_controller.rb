# frozen_string_literal: true

class CurrentUser::ContributionsController < ApplicationController
  before_action :set_repository, only: %i[index]

  def index
    @issues = current_user.issues.eager_load(:repository).order(:created_at)
    @assigned_issues = current_user.assigned_issues.eager_load(:repository).preload(:labels, pull_requests: :assignees).order(:created_at)
    @reviewed_issues = current_user.reviewed_issues.eager_load(:repository).preload(:labels, pull_requests: :reviewers).order(:created_at)
    @wikis = current_user.wikis.eager_load(:repository).order(:created_at)
  end
end
