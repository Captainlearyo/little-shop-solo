class Merchants::DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = Discount.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.create(discount_params)
    redirect_to merchant_discounts_path(@merchant) 
    flash[:notice] = 'Discount was successfully created.'
     
  
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.find(params[:id])
    @discount.destroy
    redirect_to merchant_discounts_path(@merchant)
    flash[:notice] = 'Discount was successfully deleted.'
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.find(params[:id])
    @discount.update(discount_params)
    redirect_to merchant_discount_path(@merchant, @discount)
  end

  private

  def discount_params
    params.require(:discount).permit(:name, :percentage_discount, :quantity_threshold)
  end
end