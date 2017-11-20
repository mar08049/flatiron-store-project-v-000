class CartsController < ApplicationController

  def index
    @carts = Cart.all
  end

  def show
    @current_cart = Cart.find(params[:id])
  end

  def checkout
    current_user.update(current_cart: nil)
    @current_cart = Cart.find(params[:id])
    @current_cart.checkout_cart
    redirect_to cart_path(@current_cart)
  end
end
