# frozen_string_literal: true

class CurrentUser::IssuesController < ApplicationController
  before_action :set_repository, only: %i[index]

  def index
    @issues =
      case params[:association]
      when 'assigned'
        current_user.assigned_issues.includes(%i[repository labels]).order(:created_at)
      when 'reviewed'
        current_user.reviewed_issues.includes(%i[repository labels]).order(:created_at)
      else
        current_user.issues.includes(%i[repository labels]).order(:created_at)
      end
  end
end
