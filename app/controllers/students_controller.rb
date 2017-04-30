class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
    render json: { student: { name: @student.name, progress: { lesson: @student.lesson, lesson_part: @student.lesson_part } } }
  end
end
