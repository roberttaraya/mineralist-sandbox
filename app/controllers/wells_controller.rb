class WellsController < ApplicationController
  def index
    @wells = Well.all.limit(100)
  end
end
