require 'rails_helper'

describe SearchResultsController do
  it_should_behave_like "authorized controller", ->(_) { get :index }

  let!(:user) { FactoryGirl.create(:user) }
  let!(:category1) { FactoryGirl.create(:category, user: user) }
  let!(:category2) { FactoryGirl.create(:category, user: user) }

  let(:collection) { FactoryGirl.create(:collection, user: user) }

  let(:lenon) { FactoryGirl.create(:monument, collection: collection,
                                                  category: category1,
                                                  name: "John Lenon") }
  let(:lenin) { FactoryGirl.create(:monument, collection: collection,
                                                  category: category2,
                                                  name: "Vladimir Lenin") }

  before do
    session[:user_id] = user.id
  end

  describe "#index" do
    it "sets assigns" do
      get :index

      expect(assigns[:monuments]).to eq []
      expect(assigns[:categories]).to match_array [category1, category2]
    end
  end

  describe "#create" do
    context "no params passed" do
      it "returns all monuments" do
        post :create

        expect(assigns[:monuments]).to match_array [lenon, lenin]
      end
    end

    context "only name is passed" do
      it "finds monuments with matched name" do
        post :create, name: "John"

        expect(assigns[:monuments]).to match_array [lenon]
      end
    end

    context "only category_id is passed" do
      it "find monuments by category" do
        post :create, category_id: category2.id

        expect(assigns[:monuments]).to match_array [lenin]
      end
    end

    context "both name and category_id id passed" do
      context "both match" do
        it "returns matched monuments" do
          post :create, category_id: category2.id, name: "Vladimir"

          expect(assigns[:monuments]).to match_array [lenin]
        end
      end

      context "one of params does not match" do
        it "returns nothing" do
          post :create, category_id: category2.id, name: "John"

          expect(assigns[:monuments]).to be_empty
        end
      end
    end
  end
end
