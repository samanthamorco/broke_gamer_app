class Api::V1::DealsController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :authenticate_admin!, except: [:index, :new, :create]


  def show
    @deal = Deal.find_by(id: params[:id])
  end

  def index
    @deals = Deal.all
  end


end
