class WikisController < ApplicationController
  def index
    if current_user == nil or current_user.role == "free"
      # If guest or free signed-in user then just show the public wikis
      @wikis = Wiki.all.reject { |wiki| wiki.private? }

    elsif current_user.role == "premium"
      # Keep all public wikis
      @wikis = Wiki.all.reject { |wiki| wiki.private? }

      # And then add back all private wikis for which the owner is the current user
      user_wikis = Wiki.where(:private => true, :user_id => current_user.id)
      user_wikis.each do |wiki|
        @wikis << wiki
      end

    elsif current_user.role ==  "admin"
      # Admin sees all, knows all
      @wikis = Wiki.all
    end

    # TODO: The above has NO business being in the controller.
    # Would be handled much nicer in a scope. And probably better performance just using SQL queries.
    # The pundit gem supports adding scopes to their policies
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.owned_wikis.build(wiki_params)

    if @wiki.save
      redirect_to wikis_path, notice: "wiki was saved successfully."
    else
      flash[:error] = "Error creating wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.update_attributes(wiki_params)

    if @wiki.save
      redirect_to @wiki
    else
      flash[:error] = "Error saving wiki. Please try again"
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice]= "Wiki successfully removed"
      redirect_to :wikis
    else
      flash[:error] = "Sorry, there was an error in deleting the wiki please try again"
      render :index
    end

  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user_id)
  end
end
