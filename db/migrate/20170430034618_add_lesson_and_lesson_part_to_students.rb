class AddLessonAndLessonPartToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :lesson, :integer, default: 1, null: false
    add_column :students, :lesson_part, :integer, default: 1, null: false
  end
end
