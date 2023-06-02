class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end
end