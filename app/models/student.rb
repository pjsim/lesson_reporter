class Student < ApplicationRecord
  # A newly created student will start at lesson 1, part 1 (database defaults)

  belongs_to :teacher, optional: true # A student might not always have a teacher assigned to them

  validates :name, presence: true

  validates :lesson, numericality:
                       { greater_than_or_equal_to: 1,
                         less_than_or_equal_to: 100 }

  validates :lesson_part, numericality:
                       { greater_than_or_equal_to: 1,
                         less_than_or_equal_to: 3 }

  # Validate the lessons are only updated sequentially (if not using the advance! method)
  validate :lesson_and_parts_update_sequentially, on: :update

  # Student is able to progress to the next lesson unless they have reached lesson 100, part 3
  def can_progress?
    lesson < 100 || lesson_part < 3
  end

  # Assign the student the next sequential lesson if able to do so
  def advance
    assign_attributes lesson: next_lesson, lesson_part: next_part if can_progress?
    self
  end

  # Assign the student to the next sequential lesson and commit to the database
  def advance!
    update! lesson: next_lesson, lesson_part: next_part if can_progress?
  end

  private

  def lesson_and_parts_update_sequentially
    # If any changes are made to lesson or lesson_part, assign variables to them
    previous_lesson = changes[:lesson]&.[] 0
    previous_part = changes[:lesson_part]&.[] 0

    # Duplicate the student to what it was before any changes
    previous_student = dup
    previous_student.lesson = previous_lesson if previous_lesson
    previous_student.lesson_part = previous_part if previous_part

    # Progress the duplicate to the next sequential lesson and compare to the changes proposed
    advanced_student = previous_student.advance
    if !((previous_lesson || previous_part) && self.attributes.slice("lesson", "lesson_part") == advanced_student.attributes.slice("lesson", "lesson_part"))
      errors.add :student, "can only progress to lesson #{advanced_student.lesson}, part #{advanced_student.lesson_part}"
    end
  end

  # Increment the lesson if on part 3 of a lesson, unless at lesson 100
  def next_lesson
    (lesson < 100 && lesson_part == 3) ? lesson + 1 : lesson
  end

  # Increment the lesson part unless on part 3
  def next_part
    lesson_part != 3 ? lesson_part + 1 : 1
  end
end
