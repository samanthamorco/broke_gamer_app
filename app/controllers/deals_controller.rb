class DealsController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index
    @products = []
    @deals = Deal.where(status: "active")
    count = 0
    if params[:page]
      page = params[:page]
    else
      page = 1
    end
    @total_pages = (@deals.length / 9)
    if (@deals.length % 9) > 0
      @total_pages += 1
    end
    p @total_pages
    if ((@deals.length / page.to_i) - 9) < 1
      i = (@deals.length / page.to_i).to_i
    else
      i = 9
    end
    i.times do
      @deal = @deals[count * page.to_i]
      p @deal
      if @deal == nil
        break
      else
        if count % 2 == 1
          product_hash = Unirest.get("http://api.bestbuy.com/v1/products(sku=#{@deal.product_id})?show=name,sku,salePrice,longDescription,manufacturer,categoryPath, platform,releaseDate,image&format=json&apiKey=#{ENV['API_KEYS']}").body
        else
          product_hash = Unirest.get("http://api.bestbuy.com/v1/products(sku=#{@deal.product_id})?show=name,sku,salePrice,longDescription,manufacturer,categoryPath, platform,releaseDate,image&format=json&apiKey=#{ENV['API_KEY']}").body
        end
          count += 1
          product_initial = product_hash["products"].first
          p product_hash["products"]
          product = Product.new(product_initial)
          @products << product
        end
      end
  end

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
    @deal = Deal.new(product_id: params[:product_id], price: params[:price], url: params[:url], comment: params[:comments], user_id: current_user.id)  
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
    @deal.update(status: params[:status], url: params[:url], comment: params[:comment])
    flash[:success] = "This game has been updated!"
    redirect_to "/deals"
  end

  def destroy
    id = params[:id]
    @deal = Deal.find_by(id: id)
    @deal.update(status: "inactive")
    redirect_to "/deals"
  end

end
