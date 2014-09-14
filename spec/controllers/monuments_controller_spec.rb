require "rails_helper"

describe MonumentsController do
  it_should_behave_like "authorized controller", ->(_) { get :new, collection_id: 15 }

  let!(:user)       { FactoryGirl.create(:user) }
  let!(:collection) { FactoryGirl.create(:collection, user: user) }
  let(:category)    { FactoryGirl.create(:category, user: user) }
  let(:monument)    { FactoryGirl.create(:monument, collection: collection) }

  let(:valid_params) {{
    collection_id: collection.id,
    monument: {
      name:        "Lenin",
      description: "Lenin in Kharkiv",
      category_id: category.id
    }
  }}

  let(:invalid_params) do
    valid_params.dup.tap do |params|
      params[:monument][:name] = ""
    end
  end

  before do
    session[:user_id] = user.id
  end

  describe "#new" do
    let!(:categories) { FactoryGirl.create_list(:category, 2, user: user) }

    it "assigns @monument and @categories" do
      get :new, collection_id: collection.id

      expect(assigns[:monument]).to be_a Monument
      expect(assigns[:categories]).to eq categories
    end
  end

  describe "#create" do
    context "valid params" do
      it "creates new monument" do
        post :create, valid_params

        expect(response).to redirect_to collection_path(collection)

        new_monument = user.monuments.last
        expect(new_monument.name).to eq "Lenin"
        expect(new_monument.description).to eq "Lenin in Kharkiv"
      end
    end

    context "invalid parmas" do
      it "renders new form" do
        post :create, invalid_params

        expect(response).to render_template("new")
        expect(assigns[:monument]).to be_a Monument
        expect(user.monuments.count).to eq 0
      end
    end
  end

  describe "#show" do
    it "assigns @monument" do
      get :show, collection_id: collection.id, id: monument.id

      expect(assigns[:monument]).to eq monument
    end
  end

  describe "#destroy" do
    it "removes monument" do
      delete :destroy, collection_id: collection.id, id: monument.id

      expect(response).to redirect_to collection_path(collection)
      expect(Monument.find_by_id(monument.id)).to be_nil
    end
  end

  describe "#edit" do
    it "assigns @monument" do
      get :edit , collection_id: collection.id, id: monument.id

      expect(assigns[:monument]).to eq monument
    end
  end

  describe "#update" do
    context "valid params" do
      it "updates monument" do
        put :update, valid_params.merge(id: monument.id)

        expect(response).to redirect_to collection_path(collection)

        monument.reload
        expect(monument.name).to eq "Lenin"
        expect(monument.description).to eq "Lenin in Kharkiv"
      end
    end

    context "invalid params" do
      it "renders edit template" do
        put :update, invalid_params.merge(id: monument.id)

        expect(response).to render_template("edit")
      end
    end
  end
end
