require 'rails_helper'

RSpec.describe TeachersController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let(:teacher) { Teacher.create!(name: Faker::Name.name) }
    let(:student) { Student.create!(name: Faker::Name.name, teacher: teacher) }

    it 'returns http success with a valid teacher id in params' do
      get :show, params: { id: teacher.to_param }
      expect(response).to have_http_status(:success)
    end

    it 'returns 404 with an invalid teacher id in params' do
      get :show, params: { id: '2000' }
      expect(response).to have_http_status(404)
    end
  end
end
