class DealsController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :authenticate_admin!, except: [:index, :new, :create]


  def show
    @deals = Deal.where(status: "pending")
  end

  def new
    if params[:id]
      @deal = Deal.new
    else
      flash[:danger] = "Please select a product!"
      redirect_to "/"
    end  
  end

  def create
    # @deal = Deal.new(deal_params)
    param_date = params[:date]
    date = Date.parse(param_date)
    @deal = Deal.new(product_id: params[:product_id], price: params[:price], url: params[:url], comment: params[:comments], user_id: current_user.id, date: date)  
    if @deal.save
      if current_user.role_id == 2
        @deal = @deal.update(status: "pending")
      else
        @deal = @deal.update(status: "active")
      end     
      flash[:success] = "Deal Added"
      redirect_to "/products/#{params[:product_id]}"
    else
      flash[:danger] = "Error!"
      render :new
    end
  end

  def edit
    @deal = Deal.find(params[:id])
  end

  def update
    @deal = Deal.find_by(id: params[:id])
    p params[:id]
    @deal.update(status: params[:status], url: params[:url], comment: params[:comment])
    flash[:success] = "This game has been updated!"
    redirect_to "/deals/pending"
  end

  def destroy
    id = params[:id]
    @deal = Deal.find_by(id: id)
    @deal.update(status: "inactive")
    redirect_to "/deals"
  end

  def index
    # @products = []
    # @prices = []
    if params[:order]
      @deals = Deal.sort(params[:order])
    else
      @deals = Deal.where(status: "active")
    end

    if params[:page]
      page = params[:page]
    else
      page = 1
    end


    @total_pages = Deal.total_pages(@deals)

    total_products = Deal.total_products(@deals, page)
    @products = total_products[0]
    @prices = total_products[1]
  end
end
