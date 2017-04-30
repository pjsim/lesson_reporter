class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update]

  def index
    @students = Student.all
  end

  def show
    render json: {
      student: {
        name: @student.name, progress: {
          lesson: @student.lesson, lesson_part: @student.lesson_part
        }
      }
    }
  end

  def edit
  end

  def update
    if @student.update(student_params)
      redirect_to students_path, notice: "#{@student.name}'s progression was successfully updated."
    else
      render :edit
    end
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:lesson, :lesson_part)
  end
end
