class PagesController < ApplicationController

  def index
    @deals = Deal.where(status: "active")
    @products = @deals.order('price ASC')

  end
end
