class WebhooksController < ApplicationController
	# skip_before_action :authenticate_user!
	# skip_before_action :verify_authenticity_token

	def create
		payload = request.body.read
		sig_header = request.env['HTTP_STRIPE_SIGNATURE']
		event = nil
	
		begin
			event = Stripe::Webhook.construct_event(
				payload, sig_header, Rails.application.credentials.dig(:stripe, :webhook)
			)
		rescue JSON::ParserError => e
			render json: { message: 'Invalid payload' }, status: 400
			return
		rescue Stripe::SignatureVerificationError => e
			# Invalid signature
			puts "Signature error"
			p e
			return
		end
	
		# Handle the event
		case event.type
		when 'checkout.session.completed'
			session = event.data.object
			product = Product.find_by(price: session.amount_total)
			product.increment!(:sales_count)
		end
	
		# Fetch the stored webhook event from the database
		webhook_event = WebhookEvent.find_by(event_type: event.type, payload: event.to_hash)
	
		render json: { message: 'success', webhook_event: webhook_event }
	end
	
end