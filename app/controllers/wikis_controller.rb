class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
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
