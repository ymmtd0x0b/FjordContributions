# frozen_string_literal: true

class CurrentUsers::WikisController < ApplicationController
  before_action :set_repository, only: %i[index]

  def index
    @wikis = current_user.wikis.eager_load(:repository).order(:created_at)
  end
end
