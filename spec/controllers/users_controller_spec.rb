require 'rails_helper'

describe UsersController, type: :controller do
  describe '#new' do
    it 'renders the template with a new object' do
      get :new

      expect(assigns(:user)).to be_a User
      expect(assigns(:user).new_record?).to be true
      expect(response).to be_success
    end
  end

  describe '#create' do
    context 'with valid inputs' do
      it 'creates a new user account and sign her in' do
        post :create, { user:
          { email: 'user@example.com', password: 'abcd1234' } }

        expect(response).to redirect_to root_url
      end
    end

    context 'with invalid inputs' do
      it 'renders new page' do
        post :create, { user: { email: '', password: '' } }

        expect(response).to be_success
        expect(response).to render_template(:new)
      end
    end
  end
end
