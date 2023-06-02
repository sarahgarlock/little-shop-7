class Admin::DashboardController < ApplicationController
  def index
    @customers = Customer.all
  end
end