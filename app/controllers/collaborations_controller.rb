class CollaborationsController < ApplicationController
  def create
    @user = User.find(params[:collaboration][:user_id])
    @wiki = Wiki.find(params[:wiki_id])

    session[:return_to] ||= request.referer

    if Collaboration.where(:user_id => @user.id, :wiki_id => @wiki.id).empty?
      collaboration = @user.collaborations.build(:wiki_id => @wiki.id)
    else
      flash[:error] = "That user is already listed as a collaborator"
      redirect_to session.delete(:return_to)
      return
    end

    # TODO: The block above is a total kludge
    # But basically what it's trying to do is check to see if a collaboration between the given user and the id already exists
    # If it does then it won't make a new one.
    # I assume that the better way to do this would be to add a validation to the model but I haven't figured out how to do that yet.

    if collaboration.save # This doesn't work anymore because it's not a validation because we haven't really created a validation
      redirect_to session.delete(:return_to)
    else
      # Flash error message
      redirect_to session.delete(:return_to)
    end
  end

  def destroy
    @collaboration = Collaboration.find(params[:id])
    @wiki = Wiki.find(params[:wiki_id])

    if @collaboration.destroy
      flash[:notice] = "#{@collaboration.user.name} removed as collaborator"
    else
      flash[:error] = "There was a problem removing this collaborator."
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def collaboration_params
    params.require(:collaboration).permit(:user_id, :wiki_id)
  end
end
