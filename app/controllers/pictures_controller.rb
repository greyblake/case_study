class PicturesController < AuthorizedController
  before_filter :fetch_monument
  before_filter :fetch_picture, only: %i(show edit update destroy)

  def new
    @picture = @monument.pictures.build
  end

  def create
    @picture = @monument.pictures.build(picture_params)

    if @picture.save
      flash[:notice] = "Picture is uploaded"
      redirect_to monument_picture_path(@monument, @picture)
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @picture.update(picture_params)
      flash[:notice] = "Picture is updated"
      redirect_to monument_picture_path(@monument, @picture)
    else
      render "edit"
    end
  end

  def destroy
    @picture.destroy
    flash[:notice] = %Q(Picture "#{@picture.name}" is removed)
    redirect_to collection_monument_path(@monument.collection, @monument)
  end



  private def picture_params
    params.require(:picture).permit(:name, :picture, :description)
  end

  private def fetch_picture
    @picture = @monument.pictures.find_by_id(params[:id])
    redirect_to collection_monument_path(@monument.collection, @monument) unless @picture
  end

  private def fetch_monument
    @monument = current_user.monuments.find_by_id(params[:monument_id])
    redirect_to collections_path unless @monument
  end
end
