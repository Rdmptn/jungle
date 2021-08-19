class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD']

  def show
    @categories_count = Category.all.count
    @products_count = Product.all.count
  end
end
