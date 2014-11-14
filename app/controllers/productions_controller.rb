class ProductionsController < ApplicationController
  def index
    @productions = Production.all.limit(100)
  end
end
