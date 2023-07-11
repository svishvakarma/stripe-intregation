class CheckoutController < ApplicationController
	def create
		product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
    success_url: success_product_url(product),
    cancel_url: cancel_product_url(product),
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

  def success
    product = Product.find(params[:id])
    product.update(payment_status: :success)
  
    # You can perform other actions or redirect as needed
    redirect_to product, notice: 'Payment successful. Thank you!'
  end
  
  def cancel
    product = Product.find(params[:id])
    product.update(payment_status: :failed)
  
    # You can perform other actions or redirect as needed
    redirect_to product, alert: 'Payment cancelled.'
  end
end
