class PaymentsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @user = current_user
    token = params[:stripeToken]
  # Create the charge on Stripe's servers - this will charge the user's card
  begin
    charge = Stripe::Charge.create(
      :amount => @product.price_in_cents.to_i, # amount in cents, again
      :currency => "usd",
      :source => token,
      :description => params[:stripeEmail]
    )
    if charge.paid
 	  		Order.create(
 	  			:product_id => @product,
 	  			:user_id => @user,
 	  			:total => @product.price_in_cents.to_i
 	  			)
 end

  rescue Stripe::CardError => e
    # The card has been declined
    body = e.json_body
    err = body[:error]
    flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
  end
  redirect_to product_path(@product)
end
end
