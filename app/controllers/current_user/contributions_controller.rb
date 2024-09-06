# frozen_string_literal: true

class CurrentUser::ContributionsController < ApplicationController
  include Settable
  before_action :set_repository, only: %i[index]

  def index
    @issues = current_user.issues.order(:created_at)
    @assigned_issues = current_user.assigned_issues.order(:created_at)
    @reviewed_issues = current_user.reviewed_issues.order(:created_at)
    @wikis = current_user.wikis.order(:created_at)
  end
end
