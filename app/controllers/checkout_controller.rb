class CheckoutController < ApplicationController
	def create
		product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
    success_url: root_url,
    cancel_url: root_url,
    payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'inr',
          unit_amount: product.price,
          product_data: {
            name: product.name
          }
        },
        quantity: 1
      }],
      mode: 'payment',
    })

    if @session
      Invoice.create(product: product, amount: product.price, status: 'Paid')
      redirect_to @session.url, allow_other_host: true
    else
      redirect_to root_url, alert: 'Failed to create Stripe Checkout session.'
    end
  end
end
