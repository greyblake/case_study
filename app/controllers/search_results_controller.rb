# Searches for monuments by name and category.
class SearchResultsController < AuthorizedController
  before_filter :fetch_categories

  def index
    @monuments = []
  end

  def create
    @monuments = current_user.monuments

    if params[:name].present?
      @monuments = @monuments.where("monuments.name LIKE ?", "%#{params[:name]}%")
    end

    if params[:category_id].present?
      @monuments = @monuments.where(:category_id => params[:category_id])
    end

    render "index"
  end


  private def fetch_categories
    @categories = current_user.categories
  end
end
