class CheckoutController < ApplicationController
	def create
		product = Product.find(params[:id])
		@session = Stripe::Checkout::Session.create({
		success_url: root_url,
    cancel_url: root_url,
    payment_method_types: ['card'],
    line_items: [{
      price_data: {
        currency: 'usd',
        unit_amount: product.price,
        product_data: {
          name: product.name
        }
      },
      quantity: 1
    }],
		mode: 'payment',
	})
  
		redirect_to @session.url, allow_other_host: true
	end
end