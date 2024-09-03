# frozen_string_literal: true

class Users::WikisController < ApplicationController
  include Settable
  before_action :set_repository, only: %i[index]
  def index
    @wikis = current_user.wikis.order(:created_at)
  end
end
