require 'rails_helper'

describe UsersController do
  describe '#new' do
    it 'assigns new user' do
      get :new
      expect(assigns(:user)).to be_a User
      expect(assigns(:user)).to be_new_record
    end
  end

  describe '#create' do
    context 'invalid parameters' do
      before { post :create, user: { login: "john" } }

      it 'does not create new user' do
        expect(User.count).to eq 0
      end

      it 'renders new template' do
        expect(response).to render_template(:new)
      end
    end

    context 'valid parameters' do
      before do
        post :create, user: { login:                 'john',
                              password:              '12345678',
                              password_confirmation: '12345678' }
      end

      it 'creates new user' do
        expect(User.last.login).to eq 'john'
      end

      it 'redirects to collections' do
        expect(response).to redirect_to collections_path
      end

    end
  end
end
