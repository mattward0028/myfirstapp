require 'rails_helper'

describe UsersController, :type => :controller do

#  let(:user1) { User.create!(email: 'peter@example.com', password: '1234567890') }
#  let(:user2) { User.create!(email: 'peter2@example.com', password: '1234567890') }

user1 = FactoryGirl.create(:user)
user2 = FactoryGirl.create(:user)

  describe 'GET #show' do
		context 'User is logged in' do
			before do
				sign_in user1
			end

			it 'loads correct user details' do
				get :show, id: user1.id
				expect(response).to have_http_status(200)
				expect(assigns(:user)).to eq user1
			end

			it 'redirects to root_path' do
				get :show, id: user2.id
				expect(response).to redirect_to(root_path)
			end
		end

		context 'No user is logged in' do
			it 'redirects to login' do
				get :show, id: user1.id
        expect(response).to have_http_status(302)
        expect(response).to redirect_to('/login')
			end
		end
	end
end
