require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    before(:example) { get users_path } # get(:index)
    it 'it is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "it renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'it should include "Here is a list of users" on the screen' do
      expect(response.body).to include('Here is a list of users')
    end
  end

  describe 'GET #show' do
    # user = User.create(name: 'Grabrielle', photo: 'mybaby.png', bio: 'A beautiful baby', post_counter: 0)
    before(:example) { get user_path(2) } # get(:show, params: { id: 2 })
    it 'it is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'show' template" do
      expect(response).to render_template('show')
    end

    it 'it should include "Here the details of a user: Name, Photo, Bio, and Posts" on the screen' do
      expect(response.body).to include('Here the details of a user: Name, Photo, Bio, and Posts')
    end
  end
end
