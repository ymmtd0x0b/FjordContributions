# frozen_string_literal: true

class HighVoltage::PagesController < ApplicationController
  include HighVoltage::StaticPage
  skip_before_action :authenticate_user!
  before_action :redirect_to_current_user_issues, only: %i[show]

  private

  def redirect_to_current_user_issues
    return if !logged_in? || (params[:id] != 'welcome')

    redirect_to current_user_issues_path(association: 'assigned')
  end
end
