require "rails_helper"

describe CollectionsController do
  let(:user) { FactoryGirl.create(:user) }

  before do
    session[:user_id] = user.id
  end

  describe "#index" do
    it "renders index template" do
      collections = FactoryGirl.create_list(:collection, 2, user: user)

      get :index

      expect(response).to be_ok
      expect(response).to render_template("index")
      expect(assigns[:collections]).to eq collections
    end
  end

  describe "#new" do
    it "renders new template" do
      get :new

      expect(response).to be_ok
      expect(response).to render_template("new")
      expect(assigns[:collection]).to be_a Collection
      expect(assigns[:collection]).to be_new_record
    end
  end

  describe "#create" do
    context "invalid parameters" do
      it "does not create new collection" do
        post :create, collection: { name: "" }

        expect(Collection.count).to eq 0
        expect(response).to be_ok
        expect(response).to render_template("new")
      end
    end

    context "valid parameters" do
      it "creates a new collection" do
        post :create, collection: { name: "Kharkiv" }

        new_collection = user.collections.last
        expect(new_collection.name).to eq "Kharkiv"

        expect(response).to redirect_to collections_path
        expect(flash.notice).to eq 'Collection "Kharkiv" is created'
      end
    end
  end

  describe "#show" do
    it "renders show template" do
      collection = FactoryGirl.create(:collection, user: user)

      get :show, id: collection.id

      expect(response).to be_ok
      expect(response).to render_template("show")
      expect(assigns[:collection]).to eq collection
    end

    context "collection that belongs to another user" do
      it "redirects to collections" do
        another_user = FactoryGirl.create(:user)
        collection = FactoryGirl.create(:collection, user: another_user)

        get :show, id: collection.id

        expect(response).to redirect_to collections_path
      end
    end
  end

  context "not authorized user" do
    before { session[:user_id] = nil }

    it "redirects" do
      get :index
      expect(response).to redirect_to root_path
    end
  end
end
