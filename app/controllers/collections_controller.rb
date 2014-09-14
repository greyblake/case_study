class CollectionsController < AuthorizedController
  before_filter :fetch_collection, only: %i(show destroy edit update)

  def index
    @collections = current_user.collections
  end

  def new
    @collection = current_user.collections.build
  end

  def create
    @collection = current_user.collections.create(collection_params)

    if @collection.save
      flash[:notice] = "Collection \"#{@collection.name}\" is created"
      redirect_to collections_path
    else
      render "new"
    end
  end

  def show
  end

  def destroy
    @collection.destroy
    redirect_to collections_path
  end

  def edit
  end

  def update
    if @collection.update(collection_params)
      flash[:notice] = "Collection #{@collection.name} is updated"
      redirect_to collections_path
    else
      render "edit"
    end
  end


  private def collection_params
    params.require(:collection).permit(:name)
  end

  private def fetch_collection
    @collection = current_user.collections.find_by_id(params[:id])
    return redirect_to collections_path unless @collection
  end
end
