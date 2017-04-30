require 'rails_helper'

RSpec.describe StudentsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    let(:student) { Student.create!(name: Faker::Name.name)}

    it 'returns http success with a valid student id in params' do
      get :show, params: { id: student.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns 404 with an invalid student id in params' do
      get :show, params: { id: 2000 }
      expect(response).to have_http_status(404)
    end

    it 'returns the student\'s name and progress in JSON' do
      get :show, params: { id: student.id }
      student_as_json = { student: { name: student.name, progress: { lesson: student.lesson, lesson_part: student.lesson_part } } }.to_json

      expect(response.body).to eq student_as_json
    end
  end
end
