# frozen_string_literal: true

class Users::IssuesController < ApplicationController
  include Settable
  before_action :set_repository, only: %i[index]

  def index
    @issues =
      case params[:association]
      when 'assigned'
        current_user.assigned_issues.order(:created_at)
      when 'reviewed'
        current_user.reviewed_issues.order(:created_at)
      else
        current_user.issues.order(:created_at)
      end
  end
end
