class CategoriesController < AuthorizedController
  before_filter :fetch_category, only: %i(destroy edit update)

  def index
    @categories = current_user.categories
  end

  def new
    @category = current_user.categories.build
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      flash[:notice] = "Category \"#{@category.name}\" is created"
      redirect_to categories_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = %Q(Category "#{@category.name}" is updated)
      redirect_to categories_path
    else
      render "edit"
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = %Q(Category "#{@category.name}" is removed)
    redirect_to categories_path
  end


  private def category_params
    params.require(:category).permit(:name)
  end

  private def fetch_category
    @category = current_user.categories.find_by_id(params[:id])
    redirect_to categories_path unless @category
  end
end
