require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let(:student) { Student.create!(name: Faker::Name.name) }

    it 'returns http success with a valid student id in params' do
      get :show, params: { id: student.to_param }
      expect(response).to have_http_status(:success)
    end

    it 'returns 404 with an invalid student id in params' do
      get :show, params: { id: '2000' }
      expect(response).to have_http_status(404)
    end

    it 'returns the student\'s name and progress in JSON' do
      get :show, params: { id: student.to_param }
      student_as_json = {
        student: {
          name: student.name,
          progress: { lesson: student.lesson, lesson_part: student.lesson_part }
        }
      }.to_json

      expect(response.body).to eq student_as_json
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested student as @student' do
      student = Student.create! name: Faker::Name.name
      get :edit, params: { id: student.to_param }
      expect(assigns(:student)).to eq(student)
    end
  end

  describe 'put #update' do
    context 'with valid params' do
      it 'updates the requested student' do
        student = Student.create! name: Faker::Name.name
        put :update, params: { id: student.to_param, student: { lesson: 2, lesson_part: 2 } }
        student.reload
        expect(student.lesson).to eq 2
        expect(student.lesson_part).to eq 2
      end

      it 'redirects to students' do
        student = Student.create! name: Faker::Name.name
        put :update, params: { id: student.to_param, student: { lesson: 2, lesson_part: 2 } }
        expect(response).to redirect_to(students_path)
      end
    end

    context 'with invalid params' do
      it 're-renders the \'edit\' template' do
        student = Student.create! name: Faker::Name.name
        put :update, params: { id: student.to_param, student: { lesson: 101, lesson_part: 2 } }
        expect(response).to render_template('edit')
      end
    end
  end
end
