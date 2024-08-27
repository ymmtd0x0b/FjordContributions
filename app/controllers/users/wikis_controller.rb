# frozen_string_literal: true

class Users::WikisController < ApplicationController
  include Settable
  before_action :set_repository, only: %i[index]
  before_action :set_user, only: %i[index]

  def index
    @wikis = @user.wikis.order(:created_at)
  end
end
