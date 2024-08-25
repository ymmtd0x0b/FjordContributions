# frozen_string_literal: true

class Users::IssuesController < ApplicationController
  def index
    @repository = Repository.find_by(name: ENV['REPOSITORY_NAME'])
    @user = User.find_by(login: params[:user_login])

    @issues =
      case params[:association]
      when 'assigned'
        @user.assigned_issues
      when 'reviewed'
        @user.reviewed_issues
      else
        @user.issues
      end
  end
end
