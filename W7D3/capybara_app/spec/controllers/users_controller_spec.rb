require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject(:user) do
    User.create!(
      username: 'bob',
      password: 'password'
    )
  end

  describe 'get#index' do
    it 'renders our index template' do
      get :index, {}
      expect(response).to render_template(:index)
    end
  end

  describe "get#show" do
    it 'renders the show template' do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'get#new' do
    it 'renders our new user template' do
      get :new, {}
      expect(response).to render_template(:new)
    end
  end

  describe 'post#create' do
    let(:valid_params) { { user: { username: 'bobby', password: 'password' } } }
    let(:invalid_params) { { user: { username: 'bob', password: 'pass' } } }

    context 'with invalid params' do
      it 'validates the presence of the users username and password' do
        post :create, params: { user: { username: 'bob', password: '' } }
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end

      it 'validates that the password is at least 7 characters long' do
        post :create, params: invalid_params
        expect(response).to render_template(('new'))
        expect(flash[:errors]).to be_present
      end

      it 'renders the :new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end

    context 'with valid params' do
      before :each do
        post :create, params: valid_params
      end

      # it 'logs in the user' do
      #   bobby = User.find_by(username: 'bobby')
      #   expect(session[:session_token]).to eq(bobby.session_token)
      # end

      it 'redirects to users page' do
        bobby = User.find_by(username: 'bobby')
        expect(response).to redirect_to(user_url(bobby))
      end
    end
  end
end
