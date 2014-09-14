class MonumentsController < AuthorizedController
  before_filter :fetch_collection
  before_filter :fetch_monument, only: %i(show destroy edit update)
  before_filter :fetch_categories, only: %i(new create edit update)

  def new
    @monument = @collection.monuments.new
  end

  def create
    @monument = @collection.monuments.new(monument_params)

    if @monument.save
      redirect_to collection_path(@collection)
    else
      render "new"
    end
  end

  def show
  end

  def destroy
    @monument.destroy
    flash[:notice] = %Q(Monument "#{@monument.name}" is removed")
    redirect_to collection_path(@collection)
  end

  def edit
  end

  def update
    if @monument.update(monument_params)
      flash[:notice] = %Q(Monument "#{@monument.name}" is updated")
      redirect_to collection_path(@collection)
    else
      render "edit"
    end
  end



  private def monument_params
    params.require(:monument).permit(:name, :description, :category_id)
  end


  private def fetch_collection
    @collection = current_user.collections.find_by_id(params[:collection_id])
    redirect_to collection_path unless @collection
  end

  private def fetch_monument
    @monument = @collection.monuments.find_by_id(params[:id])
    redirect_to collection_path(@collection) unless @monument
  end

  private def fetch_categories
    @categories = current_user.categories
  end
end
