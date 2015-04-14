class ChargesController < ApplicationController
  require 'pry'

  def new
    @stripe_btn_data = {
      :key         => "#{ Rails.configuration.stripe[:publishable_key] }",
      :description => "Blocipedia membership - #{current_user.email}",
      :amount      => 1000
    }
  end

  def create
    # Creates a Stripe Customer Object, for associating with the charge
    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      :customer    => customer.id, # This is not the same as the user id--it's coming from that Customer object
      :amount      => 1000, # In pennies, so $10
      :description => "Blocipedia Premium Membership - #{current_user.email}",
      :currency    => 'usd'
    )

    redirect_to edit_user_registration_path
    current_user.role = "premium"
    current_user.save
    flash[:success] = "Thanks for the money, #{current_user.email}! Your card was charged $#{ charge.amount / 100 }.#{ charge.amount % 100 }. Feel free to pay me again."

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
