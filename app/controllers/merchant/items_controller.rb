class Merchant::ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @enabled_items = @items.enabled
    @disabled_items = @items.disabled
    @item_rev = @items.revenue
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item.update(name: params[:name], description: params[:description], unit_price: params[:unit_price])
    if @item.update(item_params)
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
      flash[:notice] = "Item Successfully Updated"
    else
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
      flash[:alert] = "Error: Valid data must be entered"
    end
  end 

  def update_status
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
    if params[:disable] != nil
      @item.update(status: "disabled")
    elsif params[:enable] != nil
      @item.update(status: "enabled") 
    end
    @item.save
    redirect_to "/merchants/#{@merchant.id}/items"
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @merchant.items.new(item_params)
    if @merchant.save
    redirect_to "/merchants/#{@merchant.id}/items"
    flash[:notice] = "Item Successfully Created"
    else
      redirect_to "/merchants/#{@merchant.id}/items/new"
      flash[:alert] = "Error: Valid data must be entered"
    end
  end

  private 
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
