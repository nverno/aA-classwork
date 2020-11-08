require 'rails_helper'
# require 'rspec/expectations'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders the new user page' do
      get :new, {}
      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #index' do
    it 'renders the index page' do
      get :index, {}
      expect(response).to render_template('index')
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    context 'if user does exist' do
      it 'renders the show page' do
        user = FactoryBot.create(:user)
        get :show, params: { id: user.id }
        expect(response).to render_template('show')
        expect(response).to have_http_status(200)
      end
    end

    context "if user doesn't exist" do
      it 'is not a success' do
        begin
          get :show, params: { id: -1 }
        rescue StandardError
          ActiveRecord::RecordNotFound
        end
        expect(response).not_to render_template(:show)
      end
    end
  end

  describe 'POST #create ' do
    context 'with invalid params' do
      it 'renders the new template' do
        post :create, params: { user: { username: Faker::Name.name, password: '' } }
        expect(response).to redirect_to(new_user_url)
      end
      it 'provides errors' do
        post :create, params: { user: { username: Faker::Name.name, password: '' } }
        expect(flash[:errors]).to be_present
      end
    end

    context 'with valid params' do
      let(:username) { Faker::Name.name }
      before(:each) do
        post :create, params: {
          user: {
            username: username,
            password: Faker::Internet.password(min_length: 6)
          }
        }
      end

      it 'redirects to user page on success' do
        expect(response).to redirect_to(user_url(User.last))
      end

      it 'stores a new user in the database' do
        expect(User.find_by(username: username)).to be_truthy
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid params' do
      let(:user) { FactoryBot.create(:user) }
      before(:each) do
        delete :destroy, params: { id: user.id }
      end

      it 'removes the user from the database' do
        expect(User.find_by(id: user.id)).to be_falsey
      end

      it 'redirects to the users page' do
        expect(response).to redirect_to(users_url)
      end
    end
  end

  describe 'GET #edit' do
    let(:user) { FactoryBot.create(:user) }
    context 'with valid params' do
      before(:each) do
        get :edit, params: { id: User.last.id }
      end

      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'POST #update' do
    let(:user) { FactoryBot.create(:user) }
    context 'with valid params' do
      before(:each) do
        patch :update, params: { id: User.last.id, user: { username: 'bob' } }
      end

      it 'redirects to the user page' do
        expect(response).to redirect_to(user_url(User.last.id))
      end

      it 'updates the user in the database' do
        expect(User.find_by(username: 'bob')).to be_truthy
      end
    end

    context 'with invalid params' do
      before(:each) do
        patch :update, params: { id: User.last.id, user: { username: 'bob', password: '' } }
      end

      it 'contains flash errors' do
        expect(flash.now[:errors]).to be_present
      end

      it 'renders the edit template' do
        expect(response).to render_template('edit')
      end
    end
  end
end
