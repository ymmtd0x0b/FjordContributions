# frozen_string_literal: true

class CurrentUser::WikisController < ApplicationController
  before_action :set_repository, only: %i[index]

  def index
    @wikis = current_user.wikis.includes(:repository).order(:created_at)
  end
end
