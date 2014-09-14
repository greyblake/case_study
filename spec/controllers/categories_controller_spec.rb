require "rails_helper"

describe CategoriesController do
  it_should_behave_like "authorized controller", ->(_) { get :index }

  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category, user: user) }

  before do
    session[:user_id] = user.id
  end


  describe "#index" do
    it "assigns @categories" do
      categories = FactoryGirl.create_list(:category, 2, user: user)

      get :index

      expect(assigns[:categories]).to eq categories
    end
  end

  describe "new" do
    it "assigns @category" do
      get :new
      expect(assigns[:category]).to be_a Category
    end
  end

  describe "#create" do
    context "valid params" do
      it "creates new category" do
        post :create, category: { name: "Soviet monuments" }

        expect(response).to redirect_to categories_path

        new_category = user.categories.last
        expect(new_category.name).to eq "Soviet monuments"
      end
    end

    context "invalid params" do
      it "renders new template" do
        post :create, category: { name: "" }

        expect(response).to render_template("new")
        expect(assigns[:category]).to be_a Category
      end
    end
  end

  describe "#edit" do
    it "assigns @category" do
      get :edit, id: category.id

      expect(assigns[:category]).to eq category
    end
  end

  describe "#update" do
    it "updates category" do
      post :update, id: category.id, category: { name: "Esperanto" }

      expect(response).to redirect_to categories_path

      category.reload
      expect(category.name).to eq "Esperanto"
    end
  end

  describe "destroy" do
    it "deletes category" do
      delete :destroy, id: category.id

      expect(Category.find_by_id(category.id)).to be_nil
      expect(response).to redirect_to categories_path
    end
  end

end
