require 'rails_helper'

describe SessionsController do
  let!(:user) { FactoryGirl.create(:user, login: 'mike', password: 'abcd1234') }

  describe "#create" do
    context "incorrect login or password" do
      after do
        expect(response).to be_ok
        expect(flash[:alert]).to eq "Incorrect login or password"
        expect(response).to render_template(:new)
        expect(session[:user_id]).to be_nil
      end

      it "sets flash alert if user does not exist" do
        post :create, login: "batman"
      end

      it "sets flash alert if password does not match" do
        post :create, login: "mike", password: "UnuDos34"
      end
    end

    context "password matches" do
      it "redirects to collections" do
        post :create, login: 'mike', password: 'abcd1234'

        expect(response).to redirect_to collections_path
        expect(flash[:notice]).to eq "You have successfully logged in"
        expect(session[:user_id]).to eq user.id
      end
    end
  end

  describe "#destroy" do
    it "resets session[:user_id]" do
      session[:user_id] = 13

      delete :destroy

      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to root_path
      expect(flash[:notice]).to eq "You have successfully logged out"
    end
  end

  describe "before filters" do
    describe "#redirect_if_signed_in" do
      it "redirects do collections" do
        session[:user_id] = user.id

        get :new

        expect(response).to redirect_to collections_path
      end
    end
  end
end
