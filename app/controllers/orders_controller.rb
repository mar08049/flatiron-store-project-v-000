class OrdersController < ApplicationController

  def show
   @cart = Cart.find(params[:id])
  end

end
