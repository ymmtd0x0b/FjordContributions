# frozen_string_literal: true

class Users::IssuesController < ApplicationController
  def index
    @repository = Repository.find_by(name: ENV['REPOSITORY_NAME'])
    @user = User.find_by(login: params[:user_login])

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
