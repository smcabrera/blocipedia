class SubscriptionsController < ApplicationController
  def new
  end

  def create
    # Creates a Stripe Customer Object, for associating with the charge
    session[:return_to] ||= request.referer

    begin
      unless customer = Stripe::Customer.create(
        :email => current_user.email,
        :card  => params[:stripeToken]
      )

        flash[:error] = "There was a problem processing your request. Please try again."
        redirect_to edit_user_registration_path
        return
      end

      # Creating a stripe charge object
      unless charge = Stripe::Charge.create(
        :customer    => customer.id, # This is not the same as the user id--it's coming from that Customer object
        :amount      => 1000, # In pennies, so $10
        # TODO:  Create class and call Amount.default rather than hardcoding
        :description => "Blocipedia Premium Membership - #{current_user.email}",
        :currency    => 'usd')

        flash[:error] = "There was a problem creating the charge. Please try again"
        redirect_to edit_user_registration_path
        return
      end

    rescue Stripe::CardError => e
      redirect_to edit_user_registration_path
      flash[:error] = e.message
    end

    #if current_user.build_subscription(:customer_id => customer.id)
  #  current_user.customer_id = customer.id
    current_user.role = "premium"
    binding.pry
      current_user.save
      flash[:success] = "Thanks for the money, #{current_user.email}! Your card was charged $#{ charge.amount / 100 }.#{ charge.amount % 100 }."
      #flash[:notice] = "Successfully subscribed."
    #else
      flash[:error] = "There was a problem processing your request. Please try again."
    #end

    redirect_to root_path
  end

  def destroy
    current_user
    current_user.role = "free"
    session[:return_to] ||= request.referer

    if current_user.subscription
      subscription = current_user.subscription
    else
      raise "Error: Premium users should have subscription"
    end

    if subscription.destroy
      current_user.save
      flash[:notice] = "Successfully unsubscribed."
    else
      flash[:error] = "There was a problem processing your request. Please try again."
    end
    redirect_to root_path
  end
end

