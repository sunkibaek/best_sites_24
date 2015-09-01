require 'rails_helper'

describe SessionsController, type: :controller do
  describe 'constants' do
    it 'returns strings' do
      expect(SessionsController::MSG_WELCOME).to be_a String
    end
  end

  describe '#new' do
    subject { get :new }

    it 'renders new template successfully' do
      expect(subject).to be_success
      expect(subject).to render_template :new
    end
  end

  describe '#create' do
    let!(:user) do
      create :user, email: 'test@example.com', password_digest: 'pass1234'
    end

    subject do
      post :create, session: { email: 'test@example.com', password: 'pass1234' }
    end

    it 'signs user in' do
      expect(subject).to redirect_to new_site_url
      expect(flash[:notice]).to have_content SessionsController::MSG_WELCOME
    end
  end

  describe '#destroy' do
    subject { delete :destroy }

    context 'when signed in' do
      it 'signs her out' do
        user = create :user

        sign_in user

        expect(subject).to redirect_to root_url
      end
    end

    context 'when NOT signed in' do
      it 'denies access' do
        expect(subject).to redirect_to new_session_url
      end
    end
  end
end
