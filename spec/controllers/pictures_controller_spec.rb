require "rails_helper"

describe PicturesController do
  it_should_behave_like "authorized controller", ->(_) { get :new, monument_id: 125 }

  let!(:user)       { FactoryGirl.create(:user) }
  let!(:collection) { FactoryGirl.create(:collection, user: user) }
  let(:monument)    { FactoryGirl.create(:monument, collection: collection) }
  let(:picture)     { FactoryGirl.create(:picture, monument: monument) }

  let(:valid_params) {{
    monument_id: monument.id,
    picture: {
      name:        "Lenin-1",
      picture:     fixture_file_upload("liberty.jpeg", "image/jpeg"),
      description: "Yet another Lenin"
    }
  }}

  let(:invalid_params) do
    valid_params.dup.tap do |params|
      params[:picture][:name] = ""
    end
  end

  before do
    session[:user_id] = user.id
  end


  describe "#new" do
    it "assigns @picture" do
      get :new, monument_id: monument.id

      expect(assigns[:picture]).to be_a Picture
    end
  end

  describe "#create" do
    context "valid params" do
      it "creates new picture" do
        post :create, valid_params

        new_picture = monument.pictures.last
        expect(new_picture).to be_present
        expect(new_picture.name).to eq "Lenin-1"

        expect(response).to redirect_to monument_picture_path(monument, new_picture)
      end
    end

    context "invalid params" do
      it "renders form again" do
        post :create, invalid_params

        expect(response).to render_template("new")
        expect(assigns[:picture]).to be_a Picture
      end
    end
  end

  describe "#show" do
    it "assigns @picture" do
      get :show, monument_id: monument.id, id: picture.id

      expect(assigns[:picture]).to be_a Picture
    end
  end

  describe "#edit" do
    it "assigns @picture" do
      get :edit, monument_id: monument.id, id: picture.id

      expect(assigns[:picture]).to be_a Picture
    end
  end

  describe "#update" do
    context "valid params" do
      it "updates picture" do
        put :update, valid_params.merge(id: picture.id)

        picture.reload
        expect(picture.name).to eq "Lenin-1"
      end
    end

    context "invalid params" do
      it "renders form again" do
        put :update, invalid_params.merge(id: picture.id)

        picture.reload
        expect(picture.name).not_to eq "Lenin-1"
        expect(response).to render_template("edit")
      end
    end

  end

  describe "#destroy" do
    it "removes picture" do
      delete :destroy, monument_id: monument.id, id: picture.id

      expect(Picture.find_by_id(picture.id)).to be_nil
    end
  end
end
