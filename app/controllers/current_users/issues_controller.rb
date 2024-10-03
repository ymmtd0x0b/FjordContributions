# frozen_string_literal: true

class CurrentUsers::IssuesController < ApplicationController
  before_action :set_repository, only: %i[index]

  def index
    @issues =
      case params[:association]
      when 'assigned'
        current_user.assigned_issues.eager_load(:repository).preload(:labels).order(:created_at)
      when 'reviewed'
        current_user.reviewed_issues.eager_load(:repository).preload(:labels).order(:created_at)
      else
        current_user.issues.eager_load(:repository).preload(:labels).order(:created_at)
      end
  end
end
