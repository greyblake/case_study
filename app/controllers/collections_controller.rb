class CollectionsController < AuthorizedController
  def index
    @collections = current_user.collections
  end

  def new
    @collection = current_user.collections.build
  end

  def create
    attrs = params.require(:collection).permit(:name)
    @collection = current_user.collections.create(attrs)

    if @collection.save
      flash[:notice] = "Collection \"#{@collection.name}\" is created"
      redirect_to collections_path
    else
      render "new"
    end
  end

  def show
    @collection = current_user.collections.find_by_id(params[:id])
    redirect_to collections_path unless @collection
  end
end
