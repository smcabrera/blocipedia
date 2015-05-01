class CollaborationsController < ApplicationController
  def create
    #@user = User.find(params[:user_id])
    #@wiki = Wiki.find(params[:wiki_id])
    session[:return_to] ||= request.referer

    require 'pry'
    binding.pry
    #collaboration = current_user.collaborations.build(
      #:user_id => @user.id, :wiki_id => @wiki.id
    #)

    #collaboration = Collaboration.new()
    if collaboration.save
      redirect_to session.delete(:return_to)
    else
      # Flash error message
      redirect_to session.delete(:return_to)
    end
  end
end
