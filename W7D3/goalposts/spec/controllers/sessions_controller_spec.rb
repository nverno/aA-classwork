require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:password) { 'password' }
  subject(:user) do
    FactoryBot.create(:user, password: password)
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new, {}
      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before(:each) do
        post :create, params: { user: { username: user.username, password: password } }
      end

      it 'redirects to the user page' do
        expect(response).to redirect_to(user_url(user))
      end

      it 'logs in the current user' do
        curr = User.find_by(id: user.id)
        expect(session[:session_token]).to eq(curr.session_token)
      end
    end

    context 'with invalid params' do
      before(:each) do
        post :create, params: { user: { username: user.username, password: 'blahblah' } }
      end

      it 'contains flash errors' do
        expect(flash[:errors]).to be_present
      end

      it 'redirect to the new template' do
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'logs out the current user and destroys the :session_token' do
      post :create, params: { user: { username: user.username, password: password } }
      post :destroy
      curr = User.find_by(id: user.id)

      expect(curr.session_token).not_to eq(session[:session_token])
      expect(session[:session_token]).to be_nil
      expect(response).to redirect_to(new_session_url)
    end
  end
end
