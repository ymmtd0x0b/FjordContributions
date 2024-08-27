# frozen_string_literal: true

class Users::IssuesController < ApplicationController
  include Settable
  before_action :set_repository, only: %i[index]
  before_action :set_user, only: %i[index]

  def index
    @issues =
      case params[:association]
      when 'assigned'
        @user.assigned_issues.order(:created_at)
      when 'reviewed'
        @user.reviewed_issues.order(:created_at)
      else
        @user.issues.order(:created_at)
      end
  end
end
