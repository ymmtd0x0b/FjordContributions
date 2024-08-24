# frozen_string_literal: true

class Users::IssuesController < ApplicationController
  def index
    @repository = Repository.find_by(name: ENV['REPOSITORY_NAME'])
    @user = User.find_by(login: params[:user_login])

    @issues =
      if params[:association] == 'assigned'
        @user.assigned_issues
      else
        @user.issues
      end
  end
end
