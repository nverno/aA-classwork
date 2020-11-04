require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'get#new' do
    it 'renders our new user template' do
      get :new, {}
      expect(response).to render_template(:new)
    end
  end

  describe 'post#create' do
    let(:valid_params) { { user: { email: 'asdf@asdf.com', password: 'password' } } }
    let(:invalid_params) { { user: { email: '123@asdf.com', password: 'pass' } } }
    let(:user) { User.find_by(email: 'asdf@asdf.com') }

    context 'with valid params' do
      before :each do
        post :create, params: valid_params
      end

      it 'logs in the user' do
        expect(session[:session_token]).to eq(user.session_token)
      end

      it 'redirects to users bands page' do
        expect(response).to redirect_to(bands_url)
      end
    end

    context 'with invalid params' do
      it 'validates the presence of the users email and password' do
        post :create, params: { user: { email: 'bobby@bingo.com', password: '' } }
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end

      it 'validates that the password is at least 6 characters long' do
        post :create, params: invalid_params
        expect(response).to render_template(('new'))
        expect(flash[:errors]).to be_present
      end

      it 'renders the :new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end
end
