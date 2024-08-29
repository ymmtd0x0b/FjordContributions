# frozen_string_literal: true

class HighVoltage::PagesController < ApplicationController
  include HighVoltage::StaticPage
  skip_before_action :authenticate_user!
  before_action :redirect_to_users_issues, only: %i[show]

  private

  def redirect_to_users_issues
    return unless logged_in? && (params[:id] == 'welcome')

    redirect_to users_issues_path(current_user.login, association: 'assigned')
  end
end
