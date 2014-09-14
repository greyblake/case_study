require "rails_helper"

describe CollectionsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:collection) { FactoryGirl.create(:collection, user: user) }


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
      get :show, id: collection.id

      expect(response).to be_ok
      expect(response).to render_template("show")
      expect(assigns[:collection]).to eq collection
    end

    context "collection that belongs to another user" do
      it "redirects to collections" do
        another_user = FactoryGirl.create(:user)
        another_collection = FactoryGirl.create(:collection, user: another_user)

        get :show, id: another_collection.id

        expect(response).to redirect_to collections_path
      end
    end
  end

  describe "#destroy" do
    context "collection is found" do
      it "deletes collection and redirects to index" do
        delete :destroy, id: collection.id

        expect(Collection.find_by_id(collection.id)).to be_nil
        expect(response).to redirect_to collections_path
      end
    end

    context "collection is not found" do
      it "redirects to index" do
        delete :destroy, id: 40506080
        expect(response).to redirect_to collections_path
      end
    end
  end


  describe "#edit" do
    context "collection is found" do
      it "assigns @collection" do
        get :edit, id: collection.id

        expect(response).to be_ok
        expect(assigns[:collection]).to eq collection
      end
    end

    context "collection is not found" do
      it "redirects to index" do
        get :edit, id: 40506080
        expect(response).to redirect_to collections_path
      end
    end
  end

  describe "#update" do
    context "collection is found" do
      context "valid params" do
        it "updates the collection" do
          post :update, id: collection.id, collection: { name: "Kiev" }

          collection.reload
          expect(collection.name).to eq "Kiev"

          expect(response).to redirect_to collections_path
        end
      end

      context "invalid params" do
        it "renders edit form" do
          post :update, id: collection.id, collection: { name: "" }

          expect(response).to render_template("edit")
        end
      end
    end

    context "collection is not found" do
      it "redirects to index" do
        post :update, id: 40506080
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
