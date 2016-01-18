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
    date = DateTime.strptime(params[:date],'%m/%d/%Y').strftime("%Y-%m-%d")
    @deal = Deal.new(product_id: params[:product_id], price: params[:price], url: params[:url], comment: params[:comments], user_id: current_user.id, date: date)  
    if @deal.save
      if current_user.role_id == 2
        @deal = @deal.update(status: "pending")
        flash[:success] = "Thank you. Deal will be added upon moderator review."
      else
        @deal = @deal.update(status: "active")
        flash[:success] = "Deal Added"
      end  

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
    if params[:order]
      @deals = Deal.sort(params[:order])
    else
      @deals = Deal.sort("newest")
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
