class PermitsController < ApplicationController
  def index
    @permits = Permit.all.limit(100)
  end
end
